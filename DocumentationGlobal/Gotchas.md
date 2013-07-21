## Gotchas
Since our reports (should) have similar flows, let's describe some of the common time-killer gotchas

### REDCap
- If there's a record created, but no data entered, it could fail to be exported from REDCap by the API.  Apparently the record needs just one non-default value entered, in order to be exported with the API.  Unfortunately, the manual export feature follows different rules.  For instance, the manual CSV has 321 records (322 rows total), while the API export had 305.  I entered a value into one text box, and then the record was exported with the API.  

  This won't be a problem for the reports I can think of, since we mostly care about records with data.  However it might cause a problem with Thomas's reports like SurveyProductivity and RecruitmentProductivity. I've created [Issue 161](https://github.com/OuhscCcanMiechvEvaluation/MReporting/issues/161). {Added Feb 2013}

### Reporting
- No issues yet

### Data manipulation
- No issues yet

### Data transfer
- When using the `RODBC` package, the `sqlSave` function can be used to append records to an existing table in SQL Server (among other uses).  This [posting](http://r.789695.n4.nabble.com/some-helpful-tips-on-using-RODBC-td2324503.html) has some useful advice.  As of Nov 2012, the `RODBC` vignette isn't on its [CRAN](http://cran.r-project.org/web/packages/RODBC/index.html) site, but [here's](http://hosho.ees.hokudai.ac.jp/~kubo/Rdoc/library/RODBC/doc/RODBC.pdf) an old copy. {Added Nov 11, 2012}

- Using date values can be tricky.  One solution is to set the `fast` parameter to `FALSE`.  But with the 10,000+ record datasets given to us by other agencies, this isn't  desirable.

  The other approach is to set the `varTypes` argument (the [`smalldatetime`](http://technet.microsoft.com/en-us/library/ms182418.aspx) data type is accurate down to the minute, which typically is enough resolution for our reporting needs).  However, the date needs to be converted to a character in R before `sqlSave` is called.  In [this example](http://lojze.lugos.si/~darja/software/r/library/RODBC/tests.R), search for 'smalldatetime'. {Added Nov 11, 2012}
