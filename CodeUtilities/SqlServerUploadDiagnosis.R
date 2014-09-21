#This isn't for REDCap specifically, but a lot of our big project use SQL Server for some roles.  
#  This seemed like the best place to put this code for now.  It probably deserves to be in some package.
#  It should also be encapsulted in functions.

library(RODBC)

### Upload Visit Records to SQL Server
#############################
sapply(ds, function(x) max(nchar(x)))
# dput(colnames(ds))

## Specify columns & their order to upload
columnsToWrite <- c("ID", "NameFull", "StartDate", "StopDate", "ElapsedMonths", "CensoredLeft", "CensoredRight",
                    "Position", "Comments",  "PersonID_1", "PersonID_2", "ReviewDate", "UploadToSqlDate")
dsSlim <- ds[, columnsToWrite]

startTime <- base::Sys.time()
dbTable <- "Osdh.tblC1ClientActivity"
channel <- RODBC::odbcConnect("MiechvEvaluation") 
RODBC::getSqlTypeInfo("Microsoft SQL Server") 
RODBC::odbcGetInfo(channel)
columnInfo <- RODBC::sqlColumns(channel, dbTable)
varTypes <- as.character(columnInfo$TYPE_NAME) 
names(varTypes) <- as.character(columnInfo$COLUMN_NAME)  #varTypes
RODBC::sqlSave(channel, dsSlim, dbTable, append=TRUE, rownames=FALSE, fast=TRUE, varTypes=varTypes) 
RODBC::odbcClose(channel)
(elapsedDuration <-  Sys.time() - startTime) # 0.519052 secs 2013-10-27

#Visually inspect the dataset you're trying to upload
head(dsSlim, 15)
summary(dsSlim)

#See if the names match exactly
data.frame(DBColumnName = as.character(columnInfo$COLUMN_NAME),
           DFVariableName = colnames(dsSlim),
           Violation = (colnames(dsSlim)!=as.character(columnInfo$COLUMN_NAME))
)

#See if the there's a violoation of nulls
data.frame(ColumnName = colnames(dsSlim), 
           DBAllowsNulls = as.logical(columnInfo$NULLABLE), 
           DFHasNulls = sapply(dsSlim, function(x) { any(is.na(x)) }),
           Violation = (!as.logical(columnInfo$NULLABLE) & sapply(dsSlim, function(x) { any(is.na(x)) }))
)

#See if types are consistent
data.frame(DBType=varTypes, DFType=sapply(dsSlim, class))

#See if the there's a violoation of characters being too long. This only works for strings, not dates or numbers
data.frame(ColumnName = colnames(dsSlim), 
           DBType = varTypes,
           DBMaxSize = columnInfo$COLUMN_SIZE, 
           DFMaxSize = sapply(dsSlim, function(x) { max(nchar(x)) }),
           PossibleViolation = (!as.logical(columnInfo$COLUMN_SIZE) & sapply(dsSlim, function(x) { max(nchar(x)) }))
)
