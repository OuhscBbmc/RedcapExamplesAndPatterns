#############################
### Clear variables and load packages
#############################
rm(list=ls(all=TRUE))  #Clear the variables from previous runs. 
if( !require(lubridate) ) install.packages(lubridate, dependencies=TRUE)  #Typically you'd just write "require(lubridate)".
if( !require(plyr) ) install.packages(plyr, dependencies=TRUE)
if( !require(RCurl) ) install.packages(RCurl, dependencies=TRUE)

#############################
### Query REDCap API
#############################
rawCsvText <- RCurl::postForm(
  uri="https://zzzz.ouhsc.edu/zzzzz/API/", #Ideally, don't reveal the URL to outsiders.
  token="3941D892207A377009A4434F3D86E363", #Be very careful with real tokens.
  content='record',
  format='csv', 
  type='flat', 
  .opts=curlOptions(cainfo="./Dal/Certs/ca-bundle.crt")
#   .opts=curlOptions(ssl.verifypeer=FALSE) #If you receive an error message regarding the SSL, please see https://github.com/OuhscBbmc/RedcapGovernanceDocs/issues/12#issuecomment-24347453
)

#############################
### Convert raw text into a data.frame
#############################
head(rawCsvText) #Inspect the raw data, if desired.
ds <- read.csv(text=rawCsvText, stringsAsFactors=FALSE) #Convert the raw text to a dataset.
head(ds) #Inspect the new data.frame, if desired.

rm(rawCsvText)