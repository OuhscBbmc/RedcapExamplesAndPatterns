#rm(list=ls(all=TRUE))  #Clear the variables from previous runs.  UNcomment this only during testing, or else it will wipe out the calling code's memory.
suppressStartupMessages <- TRUE
require(RCurl, quietly=suppressStartupMessages)
require(plyr, quietly=suppressStartupMessages)
# require(reshape2, quietly=suppressStartupMessages)
require(lubridate, quietly=suppressStartupMessages)
require(stringr, quietly=suppressStartupMessages)
require(RODBC, quietly=suppressStartupMessages)
rm(suppressStartupMessages)

#############################
### Retrieve token and REDCap URL
#############################
dsnName <- "MiechvEvaluation"
channel <- RODBC::odbcConnect(dsnName) #getSqlTypeInfo("Microsoft SQL Server") #odbcGetInfo(channel)

redcapUri <- RODBC::sqlQuery(channel, "EXEC Security.prcUri @UriName = 'Redcap1'", stringsAsFactors=FALSE)[1, 'Value']
token <- RODBC::sqlQuery(channel, "EXEC [Security].[prcRedcapToken] @RedcapProjectName = 'DemoSurvey'", stringsAsFactors=FALSE)[1, 'Token']
RODBC::odbcClose(channel)
 
rm(channel, dsnName)

#############################
### Global Functions
#############################
ReplaceNAsWithFactorLevel <- function( scores, newNALabel="Unknown", addUnknownLevel=FALSE) {
  if( addUnknownLevel ) {
    levels(scores) <- c(levels(scores), newNALabel)  #Add a new level called 'Unknown'
  }
  
  scores[is.na(scores)] <- newNALabel #"Unknown"
  if(any(is.na(scores))) stop("The reassigned factor variable should not have any NA values.")
  return( scores )
}


#############################
### Query REDCap API
#############################
#Call REDCap
rawCsvText <- RCurl::postForm(
  uri=redcapUri, 
  token=token,
  content='record',
  format='csv', 
  type='flat', 
  .opts=curlOptions(cainfo="./Dal/Certs/ca-bundle.crt")
)
# head(rawCsvText) #Inspect the raw data, if desired.
demods <- read.csv(text=rawCsvText, stringsAsFactors=FALSE) #Convert the raw text to a dataset.
demods$RowID <- as.integer(row.names(demods))
object.size(demods)

rm(redcapUri, token, rawCsvText)

#############################
### Items about Interview
#############################
demods <- plyr::rename(demods, replace=c(
  "participant_id"="ParticipantID"
  ,"redcap_survey_timestamp"="TimeStamp"
  ,"gender"="Gender"
  ,"redcap_survey_identifier"="SurveyIdentifier"
  ,"date"="Date"
  ,"psycho5"="CunningManipulative"
  ,"psycho6"="LackOfRemorse"
  ,"psycho9"="ParasiticLifestyle"
  ,"psycho13"="LackOfRealisticGoals"
  ,"psycho20"="CriminalVersatility"
  ,"score"="PsychopathicScore"
  ,"comments"="Questions"
  
  
))

demods$CunningManipulative <- factor(demods$CunningManipulative, levels=1:4, labels=c("Does Not Apply", "Applies Somewhat", "Fully Applies", "Unknown"))
demods$CunningManipulative <- ReplaceNAsWithFactorLevel(demods$CunningManipulative)

demods$LackOfRemorse <- factor(demods$LackOfRemorse, levels=1:4, labels=c("Does Not Apply", "Applies Somewhat", "Fully Applies", "Unknown"))
demods$LackOfRemorse <- ReplaceNAsWithFactorLevel(demods$LackOfRemorse)

demods$ParasiticLifestyle <- factor(demods$ParasiticLifestyle, levels=0:2, labels=c("Yes", "No", "Unknown"))
demods$ParasiticLifestyle <- ReplaceNAsWithFactorLevel(demods$ParasiticLifestyle)

demods$CriminalVersatility <- factor(demods$CriminalVersatility, levels=0:2, labels=c("True", "False", "Unknown"))
demods$CriminalVersatility <- ReplaceNAsWithFactorLevel(demods$CriminalVersatility)

demods$Gender <- factor(demods$Gender, levels=1:3, labels=c("Male", "Female", "Unknown"))
demods$Gender <- ReplaceNAsWithFactorLevel(demods$Gender)

demods$SurveyIdentifier <- ReplaceNAsWithFactorLevel(demods$SurveyIdentifier)

demods$LackOfRealisticGoals <- ReplaceNAsWithFactorLevel(demods$LackOfRealisticGoals)




demods <- plyr::rename(demods, replace=c(
  psycho18___1="Never", 
  psycho18___2="LunchDetention", 
  psycho18___3="InSchoolSuspension", 
  psycho18___4="OutOfSchoolSuspension",
  psycho18___5="TrafficViolations",
  psycho18___6="MultipleLawEnforcementEncounters",
  psycho18___7="OnProbation"
))





















