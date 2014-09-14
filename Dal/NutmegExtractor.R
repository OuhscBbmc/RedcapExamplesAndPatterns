#rm(list=ls(all=TRUE))  #Clear the variables from previous runs.  UNcomment this only during testing, or else it will wipe out the calling code's memory.
# library(plyr, quietly=TRUE)
# library(dplyr, quietly=TRUE)
# library(reshape2, quietly=TRUE)
# library(lubridate, quietly=TRUE)
library(REDCapR, quietly=TRUE) #Interacts with REDCap's API
library(testit, quietly=TRUE) #Interacts with REDCap's API

#############################
### Retrieve token and REDCap URL
#############################

#With projects containing PHI, the token is loaded from a second database with `REDCapR::retrieve_token_mssql()`
token <- "9A81268476645C4E5F03428B8AC3AA7B"
uri <- "https://bbmc.ouhsc.edu/redcap/api/"

#############################
### Global Functions
#############################

ReplaceNAsWithFactorLevel <- function( scores, newNALabel="Unknown", addUnknownLevel=FALSE) {
  if( addUnknownLevel ) {
    levels(scores) <- c(levels(scores), newNALabel)  #Add a new level called 'Unknown', unless the default parameter has been changed.
  }
  
  scores[is.na(scores)] <- newNALabel #Typically "Unknown"
  if(any(is.na(scores))) stop("The reassigned factor variable should not have any NA values.")
  return( scores )
}

#############################
### Query REDCap API
#############################

#Call REDCap and verify the read was a success.  Stop if it failed.
result_1 <- REDCapR::redcap_read(redcap_uri=uri, token=token)
testit::assert("The call to REDCap was not successful.  Please inspect the values of `result_1` for more details.", result_1$success )

#Assign data.frame to 'ds'.
ds <- result_1$data

#Query a few properties of the dataset, such as its overall size and variable types.
object.size(ds)
sapply(ds, class)

#############################
### Rename variables if necessary
#############################

ds <- plyr::rename(ds, replace=c(
  "comments" = "comments_participant",
  "weight" = "weight_in_kg",
  "height" = "height_in_cm"  
))

#############################
### Convert variable types
#############################

#Convert the character to an official date
ds$dob <- as.Date(ds$dob,  "%Y-%m-%d")

#############################
### Convert to factor variables
#############################

ds$ethnicity <- factor(ds$ethnicity, levels=0:2, labels=c("Hispanic or Latino", "NOT Hispanic or Latino", "Unknown / Not Reported"))
ds$ethnicity <- ReplaceNAsWithFactorLevel(ds$ethnicity, addUnknownLevel=TRUE)

labels_race <-c("AmericanOrAlaskanNative", "Asian", "Native Hawaiian or other Pacific Islander", "Black", "White", "More than one race", "Unknown or Not reported")
ds$race <- factor(ds$race, levels=1:7, labels=labels_race)
# ds$race <- ReplaceNAsWithFactorLevel(ds$race, addUnknownLevel=FALSE)

#############################
### Convert multi-valued variables
#############################

#This particular dataset doesn't have these examples.  Here's one from a different dataset.
# demods <- plyr::rename(demods, replace=c(
#   psycho18___1="Never", 
#   psycho18___2="LunchDetention", 
#   psycho18___3="InSchoolSuspension", 
#   psycho18___4="OutOfSchoolSuspension",
#   psycho18___5="TrafficViolations",
#   psycho18___6="MultipleLawEnforcementEncounters",
#   psycho18___7="OnProbation"
# ))
