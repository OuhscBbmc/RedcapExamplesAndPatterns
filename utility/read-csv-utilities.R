#http://r.789695.n4.nabble.com/some-helpful-tips-on-using-RODBC-td2324503.html
rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
library("magrittr")
library(RODBC, quietly=TRUE)
requireNamespace("dplyr")
requireNamespace("readr")
requireNamespace("testit")

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
channel <- RODBC::odbcConnect("MiechvEvaluation") #getSqlTypeInfo("Microsoft SQL Server") #odbcGetInfo(channel)
uriExtract <- RODBC::sqlQuery(channel, "EXEC Security.prcUri @UriName = 'C1Clinic'", stringsAsFactors=FALSE)[1, 'Value']
RODBC::odbcClose(channel); rm(channel)

# ds <- read.csv(uriExtract, stringsAsFactors=FALSE, na.strings="", nrows=-100)
# classesAutomatic <- sapply(ds, class)
# 
# definition <- ""
# for( i in seq_along(classesAutomatic) ) {
#   definition <- paste0(definition, ", \"", names(classesAutomatic)[i], "\"=\"", (classesAutomatic)[i], "\"\n")
# }
# cat(definition) #Copy this output from the console and paste it below in `classes`.  And probably in the `TransferZZZExtractToDB.R` file too.

classes <- c(
  "ClinicID"        = "integer"
  , "SiteID"        = "integer"
  , "Clinic_No"     = "character" #Change from 'integer' to character, so leading zeros aren't dropped.
  , "Clinic_Name"   = "character"
  , "CountyID"      = "integer"
  , "County"        = "character"
)
# paste0("Visit", 1:93, =)

system.time(
  ds <- read.csv(uriExtract, stringsAsFactors=FALSE, na.strings="", nrows=-100, colClasses=classes, comment.char="")
)

summary(ds)

# ---- tweak-data --------------------------------------------------------------



# ---- verify-values -----------------------------------------------------------
testit::assert("All IDs should be nonmissing and positive.", all(!is.na(ds$ClinicID) & (ds$ClinicID>0)))

# ---- specify-columns-to-upload -----------------------------------------------


# ---- upload-to-db ------------------------------------------------------------

# ---- save-to-disk ------------------------------------------------------------
