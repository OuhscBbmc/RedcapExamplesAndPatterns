#This isn't for REDCap specifically, but a lot of our big project use SQL Server for some roles.  
#  This seemed like the best place to put this code for now.  It probably deserves to be in some package.

require(RODBC)

### Upload Visit Records to SQL Server
#############################
sapply(ds, function(x) max(nchar(x)))
# dput(colnames(ds))

## Specify columns & their order to upload
columnsToWrite <- c("ID", "NameFull", "StartDate", "StopDate", "ElapsedMonths", "CensoredLeft", "CensoredRight",
                    "Position", "Comments",  "PersonID_1", "PersonID_2", "ReviewDate", "UploadToSqlDate")
ds <- ds[, columnsToWrite]

startTime <- Sys.time()
dbTable <- "Osdh.tblNurseStartStopDate"
channel <- RODBC::odbcConnect("MiechvEvaluation") #getSqlTypeInfo("Microsoft SQL Server") 
odbcGetInfo(channel)
columnInfo <- RODBC::sqlColumns(channel, dbTable)
varTypes <- as.character(columnInfo$TYPE_NAME) 
names(varTypes) <- as.character(columnInfo$COLUMN_NAME)  #varTypes
RODBC::sqlSave(channel, ds, dbTable, append=TRUE, rownames=FALSE, fast=TRUE, varTypes=varTypes) 
RODBC::odbcClose(channel)
(elapsedDuration <-  Sys.time() - startTime) # 0.519052 secs 2013-10-27

#Visually inspect the dataset you're trying to upload
head(ds, 15)
summary(ds)

#See if the names match exactly
data.frame(DBColumnName=as.character(columnInfo$COLUMN_NAME),
           DFVariableName=colnames(ds),
           Violation=(colnames(ds)!=as.character(columnInfo$COLUMN_NAME)))

#See if the there's a violoation of nulls
data.frame(ColumnName=colnames(ds), 
           DBAllowsNulls=as.logical(columnInfo$NULLABLE), 
           DFHasNulls=sapply(ds, function(x) { any(is.na(x)) }),
           Violation=(!as.logical(columnInfo$NULLABLE) & sapply(ds, function(x) { any(is.na(x)) })))

#See if types are consistent
data.frame(DBType=varTypes, DFType=sapply(ds, class))

#See if the there's a violoation of characters being too long. This only works for strings, not dates or numbers
data.frame(ColumnName=colnames(ds), 
           DBType=varTypes,
           DBMaxSize=columnInfo$COLUMN_SIZE, 
           DFMaxSize=sapply(ds, function(x) { max(nchar(x)) }),
           PossibleViolation=(!as.logical(columnInfo$COLUMN_SIZE) & sapply(ds, function(x) { max(nchar(x)) })))