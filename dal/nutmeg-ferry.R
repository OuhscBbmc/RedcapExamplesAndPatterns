#rm(list=ls(all=TRUE))  #Clear the variables from previous runs.  UNcomment this only during testing, or else it will wipe out the calling code's memory.

retrieve_mice <- function( ) {
  # ---- load-sources ------------------------------------------------------------
  # Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
  
  
  # ---- load-packages -----------------------------------------------------------
  library("magrittr")
  requireNamespace("dplyr")   # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
  requireNamespace("REDCapR") # Interacts with REDCap's API. Update with devtools::install_github(repo="OuhscBbmc/REDCapR")
  requireNamespace("testit")  # Convienent assert function
  
  
  # ---- declare-globals ---------------------------------------------------------
  # With projects containing PHI, the token is loaded from a second database with `REDCapR::retrieve_credential_mssql()`
  token <- "9A81268476645C4E5F03428B8AC3AA7B"
  uri   <- "https://bbmc.ouhsc.edu/redcap/api/"
  
  labels_race <-c("AmericanOrAlaskanNative", "Asian", "Native Hawaiian or other Pacific Islander", "Black", "White", "More than one race", "Unknown or Not reported")
  
  ReplaceNAsWithFactorLevel <- function( scores, newNALabel="Unknown", addUnknownLevel=FALSE) {
    if( addUnknownLevel ) {
      levels(scores) <- c(levels(scores), newNALabel)  #Add a new level called 'Unknown', unless the default parameter has been changed.
    }
    
    scores[is.na(scores)] <- newNALabel #Typically "Unknown"
    if(any(is.na(scores))) stop("The reassigned factor variable should not have any NA values.")
    return( scores )
  }
  
  # ---- load-data ---------------------------------------------------------------
  
  #Call REDCap and verify the read was a success.  Stop if it failed.
  result_1 <- REDCapR::redcap_read(redcap_uri=uri, token=token)
  testit::assert("The call to REDCap was not successful.  Please inspect the values of `result_1` for more details.", result_1$success )
  
  #Assign data.frame to 'd'.
  d <- result_1$data
  
  #Query a few properties of the dataset, such as its overall size and variable types.
  object.size(d)
  sapply(d, class)
  
  # ---- tweak-data --------------------------------------------------------------
  d <- d %>% 
    dplyr::rename_(
      "comments_participant"    = "comments",
      "weight_in_kg"            = "weight",
      "height_in_cm"            = "height"
    ) %>% 
    dplyr::mutate(
      
      # Convert the character to an official date
      dob          =  as.Date(dob,  "%Y-%m-%d"),
  
      # Convert to factor variables
      ethnicity    = factor(ethnicity, levels=0:2, labels=c("Hispanic or Latino", "NOT Hispanic or Latino", "Unknown / Not Reported")),
      ethnicity    = ReplaceNAsWithFactorLevel(ethnicity, addUnknownLevel=TRUE),
  
      race_and_ethnicity_complete = factor(race_and_ethnicity_complete, levels=seq_along(labels_race), labels=labels_race)
  )
  
  
  # ---- return-dataset -----------------------------------------------------------
  return( d )
}


#At the top of the file of the calling code, initially source this file (to load the function's definition. )
# source("./dal/nutmeg-ferry.R")

#Retrieve all fields:
# ds <- retrieve_mice()


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
