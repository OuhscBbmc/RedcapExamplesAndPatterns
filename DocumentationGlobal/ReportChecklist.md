# Report Checklist
As you're designing each report, go through this checklist.  Help me add items to it.

## Reproducibility Issues
* The code should filter the datasets by one of the dataset's time fields, preferably by interview date. Suppose it's March 5, 2013.  A few months later, we'll still be able to roughly replicate those report by changing the stop date to March 5.  (If time doesn't really matter to you for this report, at least put start & stop dates of Jan 1 1900 and Jan 1 2200.)

## Accessibility Issues
* The graphs are explained adequately for the report's audience.
* The colors have been checked with [Color Oracle](http://colororacle.org/).
* The report has been spell-checked (if it's an external report).  It's easy to overlook mistakes in a markup/markdown document.

## Layers
A report should have at least three ordered layers.  Each layer is unaware (and not dependent) on any later layer.

1. The **table module** retrieves the data from REDCap, and then performs basic variable definition tasks.  These tasks shouldn't be specific to any report's aims.  Generic redefinitions should be preformed, like cleaning up dates or transforming numeric & character variables into factors.  For each data source, there should be only one extractor.  It should be located in the \Dal directory.  See an example of an extractor at [RedcapExamplesAndPatterns/Dal/DemoPsychopathExtractor.R](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/Dal/DemoPsychopathExtractor.R).

1. The **manipulator** transforms, aggregates, calculates, and analyzes the extracted data to produce the meat of a report.  It shouldn't care about how the data is eventually presented.  In a sense, there is a one-to-many relationship between the extractor and manipulators.  Multiple reports can use the same data source (and therefore the same extractor). The manipulator should define all the report's graphs, but it shouldn't define the exact dimensions (eg, 5x7 inches); this should be defined by the presenter.  See an example of a Manipulator at [RedcapExamplesAndPatterns/Demo/PsychopathDemo/DemoSurvey.R](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/Demo/PsychopathDemo/DemoSurvey.R).

1. The **presenter** is a thin layer on top of the manipulator.  One presenter specifies one report.  The presenter's only role is to specify the report's formatting elements; there shouldn't be any calculations, etc.  The presenter should call only the manipulator, and not the extractor.  In a sense, there is a one-to-many relationship between the manipulator and presenters.  Multiple reports can be based on the same manipulator.  For example, a quick rough report can be specified with an Rmd for internal consumption, and a fancy professional report can be specified with a knitr/LaTeX file for external consumption.  See an example of a Presenter at [RedcapExamplesAndPatterns/Demo/PsychopathDemo/DemoSurvey.R **md**](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/Demo/PsychopathDemo/DemoSurvey.Rmd).

## Security

*Transfered to https://ouhscbbmc.github.io/data-science-practices-1/security.html*

### Security for Extractor
* The REDCap password/token is stored in SQL Server and retrieved with the stored procedure `Security.prcRedcapToken`.  Don't hardcode the token in any code.
* The REDCap url is stored in SQL Server and retrieved with the stored procedure `Security.prcUri`.  Don't hardcode the url in the code.  The R code should retrieve it with something like `RODBC::sqlQuery(channel, "EXEC prcUri @UriName='Redcap1'")`.
* The file address to a CSV with PHI is stored in SQL Server and retrieved with the stored procedure `Security.prcUri`. Don't hardcode the file address in the code.
* SQL Server is accessed with an ODBC User DSN that's defined on your local computer.  The DSN uses 'Windows Integrated Security', which pulls from the credentials entered when you log into the OS.  The R code (and therefore GitHub) reveals only an innocuous DSN name (which is "MiechvEvaluation" in our case).  The DSN's definition (which isn't revealed on GitHub) has the exact server name and database name.
* You're running the extractor with a REDCap account that:
  * Doesn't have administrative privileges on REDCap.
  * Is specific to you. (HIPAA & HITECH standards require that we log which human accessed which PHI record each time.)
  * If a dataset (or a file with a password/token) was ever stored somewhere other than the file server, it has been deleted and emptied from the recycle bin.  Yet this still doesn't guarantee that a hacker can't get to it. 
* Regularly regenerate the API token for your own account. It requires two steps: (1) click the 'Regenerate Token' button in the API section of the appropriate REDCap project, and (2) paste the value into `Security.tblUri` in SQL Server. For the sake of remembering, it's probably best to regenerate it whenever your OUHSC password needs to be changed (although the two don't have anythign to do with each other).

### Security for Manipulator and Presenter
* The code calls the extractor file to retrieve the data.
* All data extraction (and related security tasks) are encapsulated in the extractor file.  The reporting code should be agnostic about the origins of the data.
* The report doesn't contain PHI, or single out members of a small group.
   * A report exposes additional security risks, because it can/should be easily distributed to people outside OUHSC.
   * As you develop a report, have someone play devil's advocate and double-check that PHI isn't unintentionally revealed.

### Security for *Receiving* PHI from Partners
* Data from the OHCA and WIC is transmitted by inviting/emailing them to upload datasets to our secured FTP site.  Remove it quickly, because the data expires after a few days.
* Data from OSDH is retrieved by visiting a portal they host.
* We don't anticipate receiving data from any other organization.  Develop a plan if this changes (and follow the note for 'Security Issues for *Sending* PHI to Partners' below).

### Security for *Sending* PHI to Partners
Currently there is not an anticipated need to send PHI to anyone outside our OUHSC team.  If the need arises as our project evolves, please develop a comprehensive plan (that addresses the relevant security issues) and describe the steps in this document.  After the plan is developed, please consult Campus IT and/or Peds IS.

### Security for GitHub

*Transfered to https://ouhscbbmc.github.io/data-science-practices-1/security.html*
  
### Guiding Security Concepts

*Transfered to https://ouhscbbmc.github.io/data-science-practices-1/security.html*

## Unit & Integration Testing
Currently,  we don't have a good plan for automated testing of our code (either unit, integration, or regression).  I'm pretty sure we'll add some, but I doubt it will ever be as good or thorough as I want, especially with the REDCap interface.

If someone has ideas, please share them.
