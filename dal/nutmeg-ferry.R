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

  # ---- load-data ---------------------------------------------------------------

  #Call REDCap and verify the read was a success.  Stop if it failed.
  result_1 <- REDCapR::redcap_read(redcap_uri=uri, token=token)
  testit::assert("The call to REDCap was not successful.  Please inspect the values of `result_1` for more details.", result_1$success )

  #Assign data.frame to 'd'.
  d <- result_1$data

  #Query a few properties of the dataset, such as its overall size and variable types.
  object.size(d)

  # ---- tweak-data --------------------------------------------------------------
  # OuhscMunge::column_rename_headstart(d)
  d <- d %>%
    dplyr::select_( #Select implicitly drops variables that aren't listed below.
      "record_id"                                = "`record_id`"
      # , "name_first"                           = "`name_first`"
      # , "name_last"                            = "`name_last`"
      # , "address"                              = "`address`"
      # , "telephone"                              = "`telephone`"
      # , "email"                                  = "`     = "`email`email`"
      , "dob"                                    = "`dob`"
      , "age"                                    = "`age`"
      , "male"                                   = "`sex`"
      , "demographics_complete"                  = "`demographics_complete`"
      , "height_in_cm"                           = "height"
      , "weight_in_kg"                           = "weight"
      , "bmi"                                    = "`bmi`"
      , "comments_participant"                   = "`comments`"
      # , "mugshot"                                = "`mugshot`"
      , "health_complete"                        = "`health_complete`"
      , "race_native_american"                   = "`race___1`"
      , "race_asian"                             = "`race___2`"
      , "race_pacific"                           = "`race___3`"
      , "race_black"                             = "`race___4`"
      , "race_white"                             = "`race___5`"
      , "race_mixed"                             = "`race___6`"
      , "ethnicity"                              = "`ethnicity`"
      , "race_and_ethnicity_complete"            = "`race_and_ethnicity_complete`"
    ) %>%
    dplyr::mutate(

      # Convert the character to an official date
      dob                                        = as.Date(dob,  "%Y-%m-%d"),

      # Convert to Boolean variables
      male                                       = as.logical(bmi),
      race_native_american                       = as.logical(race_native_american),
      race_asian                                 = as.logical(race_asian),
      race_pacific                               = as.logical(race_pacific),
      race_black                                 = as.logical(race_black),
      race_white                                 = as.logical(race_white),
      race_mixed                                 = as.logical(race_mixed),

      demographics_complete                      = as.logical(demographics_complete),
      health_complete                            = as.logical(health_complete),
      race_and_ethnicity_complete                = as.logical(race_and_ethnicity_complete),

      # Convert to factor variables
      ethnicity                                  = dplyr::recode_factor(ethnicity, `0`="Hispanic or Latino", `1`="NOT Hispanic or Latino", `2`="Unknown or Not Reported", .missing="Unknown or Not Reported")
    )


  # ---- verify-values -----------------------------------------------------------
  # Sniff out problems here, or in the specific form of the form.
  testit::assert("The record_id value must be nonmissing.", all(!is.na(d$record_id)))
  testit::assert("The BMI value must be missing or greater than 6.", all(is.na(d$bmi) | (d$bmi > 10)))
  testit::assert("The DOB values must follow Jan 1930.", all(as.Date("1930-01-01") < d$dob))


  # ---- return-dataset -----------------------------------------------------------
  return( d )

}


#At the top of the file of the calling code, initially source this file (to load the function's definition. )
# source("./dal/nutmeg-ferry.R")

#Retrieve all fields:
# ds <- retrieve_mice()
