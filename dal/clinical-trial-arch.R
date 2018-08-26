#rm(list=ls(all=TRUE))  #Clear the variables from previous runs.  UNcomment this only during testing, or else it will wipe out the calling code's memory.

retrieve_clinical_trial <- function( ) {
  # ---- load-sources ------------------------------------------------------------
  # Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.


  # ---- load-packages -----------------------------------------------------------
  library("magrittr")
  requireNamespace("dplyr")   # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
  requireNamespace("REDCapR") # Interacts with REDCap's API. Update with devtools::install_github(repo="OuhscBbmc/REDCapR")
  requireNamespace("testit")  # Convienent assert function
  requireNamespace("checkmate")  # Convienent assert function


  # ---- declare-globals ---------------------------------------------------------
  # With projects containing PHI, the token is loaded from a second database with `REDCapR::retrieve_credential_mssql()`
  path_credentials  <- "resources/example.credentials"
  credential        <- REDCapR::retrieve_credential_local(
    path_credential   = "resources/example.credentials",
    project_id        = 977L
  )

  labels_race <-c("AmericanOrAlaskanNative", "Asian", "Native Hawaiian or other Pacific Islander", "Black", "White", "More than one race", "Unknown or Not reported")

  # ---- load-data ---------------------------------------------------------------

  #Call REDCap and verify the read was a success.  Stop if it failed.
  result <- REDCapR::redcap_read(
    redcap_uri    = credential$redcap_uri,
    token         = credential$token,
    batch_size    = 200L,                         # Usually I set this 1000+.  The default '100' is conservative.
    guess_type    = FALSE                         # Read everything as a string
  )

  testit::assert("The call to REDCap was not successful.  Please inspect the values of `result` for more details.", result$success )

  #Assign data.frame to 'd'.
  d <- result$data

  #Query a few properties of the dataset, such as its overall size and variable types.
  object.size(d)

  # ---- tweak-data --------------------------------------------------------------
  # OuhscMunge::column_rename_headstart(d)
  d <- d %>%
    dplyr::select_( #Select implicitly drops variables that aren't list below.
      "record_id"
      , "name_last"
      , "name_first"
      , "address"
      , "phone"
      , "dob"
      , "ethnicity"
      , "race"
      , "gender"
      , "height_cm"                               = "`height`"
      , "weight_kg"                               = "`weight`"
      , "email"
      , "demographics_complete"

      # , "race_native_american"                   = "`race___1`"
      # , "race_asian"                             = "`race___2`"
      # , "race_pacific"                           = "`race___3`"
      # , "race_black"                             = "`race___4`"
      # , "race_white"                             = "`race___5`"
      # , "race_mixed"                             = "`race___6`"
      # , "ethnicity"                              = "`ethnicity`"
      # , "race_and_ethnicity_complete"            = "`race_and_ethnicity_complete`"
    )  %>%
    dplyr::mutate(
      record_id                         = as.integer(record_id),


      # Convert the character to an official date
      dob                                        = as.Date(dob,  "%Y-%m-%d"),

      # Create two variables for gender, for the sake of demonstration
      gender_male                       = as.logical(gender),
      gender                            = dplyr::recode(gender, `0` = "Female", `1` = "Male"),

      # Convert ethnicity from an integer to a character
      # 0	Hispanic or Latino
      # 1	NOT Hispanic or Latino
      # 2	Unknown / Not Reported
      ethnicity                         = dplyr::recode(ethnicity, `0`="Hispanic or Latino", `1`="NOT Hispanic or Latino", `2`="Unknown / Not Reported"),

      # Convert to Boolean variables
      # race_native_american                       = as.logical(race_native_american),
      # race_asian                                 = as.logical(race_asian),
      # race_pacific                               = as.logical(race_pacific),
      # race_black                                 = as.logical(race_black),
      # race_white                                 = as.logical(race_white),
      # race_mixed                                 = as.logical(race_mixed),
      #
      # demographics_complete                      = as.logical(demographics_complete),
      # health_complete                            = as.logical(health_complete),
      # race_and_ethnicity_complete                = as.logical(race_and_ethnicity_complete),
      #
      # # Convert to factor variables
      # ethnicity                                  = dplyr::recode_factor(ethnicity, `0`="Hispanic or Latino", `1`="NOT Hispanic or Latino", `2`="Unknown or Not Reported", .missing="Unknown or Not Reported")

      height_cm                         = as.numeric(height_cm),
      weight_kg                         = as.numeric(weight_kg),

      demographics_complete             = as.logical(demographics_complete)
    )


  # ---- verify-values -----------------------------------------------------------
  # Sniff out problems here, or in the specific form of the form.
  # OuhscMunge::verify_value_headstart(d2)
  checkmate::assert_integer(  d$record_id             , any.missing=F , lower=1, upper=500                                       , unique=T)
  checkmate::assert_character(d$name_last             , any.missing=F , pattern="^.{1,255}$"                                      , unique=T)
  checkmate::assert_character(d$name_first            , any.missing=F , pattern="^.{1,255}$"                                      )
  checkmate::assert_character(d$address               , any.missing=F , pattern="^.{1,255}$"                                      , unique=T)
  checkmate::assert_character(d$phone                 , any.missing=F , pattern="^.{10}$"                                     , unique=T)
  checkmate::assert_date(     d$dob                   , any.missing=F , lower=as.Date("1930-08-06"), upper=as.Date("2000-12-24") )
  checkmate::assert_character(d$ethnicity             , any.missing=F , pattern="^.{18,22}$"                                     )
  checkmate::assert_character(d$race                  , any.missing=F , pattern="^.{1,1}$"                                       )
  checkmate::assert_character(d$gender                , any.missing=F , pattern="^.{4,6}$"                                       )
  checkmate::assert_logical(  d$gender_male           , any.missing=T                                                            )
  checkmate::assert_numeric(  d$height_cm             , any.missing=F , lower=100, upper=250                                     )
  checkmate::assert_numeric(  d$weight_kg             , any.missing=F , lower= 30, upper=200                                      )
  checkmate::assert_character(d$email                 , any.missing=F , pattern="^.{7,255}$"                                     , unique=T)
  checkmate::assert_logical(  d$demographics_complete , any.missing=T                                                            )

  # ---- return-dataset -----------------------------------------------------------
  return( d )

}


#At the top of the file of the calling code, initially source this file (to load the function's definition. )
# source("./dal/clinical-trial-arch")

#Retrieve all fields:
# ds <- retrieve_clinical_trial()
