library(RODBC)
channel <- RODBC::odbcConnect("MiechvEvaluation") 
RODBC::getSqlTypeInfo("Microsoft SQL Server") 
RODBC::odbcGetInfo(channel)

redcapUrl <- RODBC::sqlQuery(channel, "EXEC Security.prcUri @UriName = 'Redcap1'", stringsAsFactors=FALSE)[1, 'Value']
token <- RODBC::sqlQuery(channel, "EXEC [Security].[prcRedcapToken] @Username = 'ReportPhiFree', @RedcapProjectName = 'Gpav2'", stringsAsFactors=FALSE)[1, 'Token']
RODBC::odbcClose(channel)

rm(channel)