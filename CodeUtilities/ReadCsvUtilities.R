#http://r.789695.n4.nabble.com/some-helpful-tips-on-using-RODBC-td2324503.html
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
require(plyr, quietly=TRUE)
require(RODBC, quietly=TRUE)
require(lubridate, quietly=TRUE)
require(stringr, quietly=TRUE)

#############################
### Declare global functions and constants
#############################


#############################
### Retrieve token and REDCap URL
#############################
dsnName <- "MiechvEvaluation"
channel <- RODBC::odbcConnect(dsnName) #getSqlTypeInfo("Microsoft SQL Server") #odbcGetInfo(channel)
uriExtract <- RODBC::sqlQuery(channel, "EXEC Security.prcUri @UriName = 'C1Clinic'", stringsAsFactors=FALSE)[1, 'Value']
RODBC::odbcClose(channel)

rm(channel, dsnName)
#############################
### Read the CSV and rename some columns
#############################
ds <- read.csv(uriExtract, stringsAsFactors=FALSE, na.strings="", nrows=-100) 
classesAutomatic <- sapply(ds, class)

definition <- ""
for( i in seq_along(classesAutomatic) ) {
  definition <- paste0(definition, ", \"", names(classesAutomatic)[i], "\"=\"", (classesAutomatic)[i], "\"\n")
}
cat(definition) #Copy this output from the console and paste it below in `classes`.  And probably in the `TransferZZZExtractToDB.R` file too.

classes <- c(
  "ClinicID"="integer"
  , "SiteID"="integer"
  , "Clinic_No"="character" #Change from 'integer' to character, so leading zeros aren't dropped.
  , "Clinic_Name"="character"
  , "CountyID"="integer"
  , "County"="character"
)
# paste0("Visit", 1:93, =)

system.time(
  ds <- read.csv(uriExtract, stringsAsFactors=FALSE, na.strings="", nrows=-100, colClasses=classes, comment.char="") 
)

summary(ds)