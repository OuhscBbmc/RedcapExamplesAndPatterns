## Setting up the R and REDCap project on a new development computer
### Installation (required)
The order matters. 

1. **[R](http://cran.r-project.org/)** is the centerpiece of the analysis. Every few months, you'll need to download the most recent version.  {added Sept 2012}
                                     
1. **[RStudio Desktop](http://www.rstudio.com/ide/download/desktop)** is the IDE (integrated design interface) that you'll use to interact with R, GitHub, Markdown, and LaTeX. Updates can be checked easily through the menus `Help` -> `Check for updates`.   {added Sept 2012}
1. **Several R Packages** will need to be installed. Running the R script [`install-packages.R`](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/utility/install-packages.R) (located in the `utility/` directory) downloads and installs only the packages that aren't already on your computer.  Create a new 'personal library' if it prompts you.  The script also updates existing packages if a newer version is available.  The list of packages will grow as we develop the reports.  Help keep the list updated. {added Sept 2012}
1. **Several R Packages** might need to be updated.  Unless you've been told not to (because it would break something -this is rare), periodically update the packages by executing the following code `update.packages(ask="graphics", checkBuilt=TRUE)`. {added Sept 2012}
1. **[GitHub](https://github.com/)** registration is necessary to push modified files to the repository.    First, register a free user account at https://github.com/plans.  Then tell the repository owner your exact username, and they'll add you as a collaborator  (eg, to https://github.com/OuhscBbmc/RedcapExamplesAndPatterns). {added Sept 2012}
1. **[GitHub for Windows Client](http://windows.github.com/)** does the basic tasks a little easier the git features built into RStudio.  {added Oct 2012}

### Installation (recommended)
The order does not matter.     

* **[ODBC Driver for SQL Server](https://www.microsoft.com/en-us/download/details.aspx?id=53339)** is for connecting to the [token server](https://github.com/OuhscBbmc/REDCapR/blob/master/vignettes/SecurityDatabase.Rmd), if your institution is using one.  As of this writing, version 13.1 is the most recent driver version.  See if a new one exists. {added Feb 2017}
* **[R Tools for Windows](https://cran.r-project.org/bin/windows/Rtools/)** is necessary to build some packages in development hosted on GitHub. {added Feb 2017}
* **[Notepad++](http://notepad-plus-plus.org/)** is a text editor that allows you look at the raw text files, such as code and CSVs.  For CSVs and other data files, it's helpful when troubleshooting (instead of looking at the file through Excel, which masks & causes some issues).  {added Sept 2012}
* **[Atom](https://atom.io/)** is a text editor, similar to Notepad++.  Notepad++ appears more efficient opening large CSVs.  Atom is better suited when editing a lot of files in a repository.  For finding and replacing across a lot of files, it is superior to Notepad++ and RStudio; it permits regexes and has a great GUI preview of the potential replacements.
* **[Pulse Secure](https://connect.ouhsc.edu)** is VPN client for OUHSC researchers.  It's not required for the REDCap API, but it's usually necessary to communicate with other campus data sources.
                         
### Installation (optional)
The order does not matter.

* **[msysGit](http://msysgit.github.com/)** allows RStudio to track changes and commit & sync them to the GitHub server. Connect RStudio to GitHub repository.  I moved this to optional (Oct 14, 2012) because the GitHub client (see above) does almost everything that the RStudio plugin does; and it does it a little better and a little more robust; and its installation hasn't given me problems.  {added Oct 2012}
  * Starting in the top right of RStudio, click: Project -> New Project -> Create Project from Version Control -> Git  {added Sept 2012}
  * An example of a repository URL is https://github.com/OuhscBbmc/RedcapExamplesAndPatterns. Specify a location to save (a copy of) the project on your local computer.  {added Sept 2012}

* **[MiKTeX](http://miktex.org/)** is necessary only if you're using knitr or Sweave to produce *LaTeX* files (and not just *markdown* files).  It's a huge, slow installation that can take an hour or two.  {added Sept 2012}
* **[CSVed](http://csved.sjfrancke.nl/)** is a lightweight program for viewing data files.  It fits somewhere between a text editor and Excel.
* **[LibreOffice Calc](https://www.libreoffice.org/discover/calc/)** is an alternative to Excel.  Unlike it Excel, it doesn't guess much with formatting (which usually mess up things, especially dates).
* **[SourceTree](http://www.sourcetreeapp.com/)** is a rich client that has many more features than the GitHub client.  I don't recommend it for beginners, since it has more ways to mess up things.  But for developers, it nicely fills a spot in between the GitHub client and command-line operations.  The branching visualization is really nice too. Unfortunately and ironically, it doesn't currently support Linux. {added Sept 2014}.
* **[git-cola](http://git-cola.github.io/)** is probably the best GUI for Git supported on Linux.  It's available through the official [Ubuntu repositories](http://packages.ubuntu.com/search?keywords=git-cola) with `apt-get` (also see [this](https://apps.ubuntu.com/cat/applications/git-cola/)).  The branch visualization features are in a different, but related program, 'git dag'.  {added Sept 2014}
* **[GitHub for Eclipse](http://eclipse.github.com/)** is something I discourage for a beginner, and I strongly recommend you start with RStudio (and [GitHub Client](http://windows.github.com/) or the git capabilities within RStudio) for a few months before you even consider Eclipse.  It's included in this list for the sake of completeness. When installing EGit plug-in, ignore eclipse site and check out this youtube video:http://www.youtube.com/watch?v=I7fbCE5nWPU.
* **[Color Oracle](http://colororacle.org/)** simulates the three most common types of color blindness.  If you have produce a color graph in a report you develop, check it with Color Oracle (or ask someone else too).  If it's already installed, it takes less than 10 second to check it against all three types of color blindness. If it's not installed, extra work may be necessary if Java isn't already installed.  When you download the zip, extract the `ColorOracle.exe` program where you like. {added Sept 2012}
* **[pandoc](http://johnmacfarlane.net/pandoc/)** converts files from one markup format into another.  We'll possibly use this to create tables in MS Word (for article submissions). {added Sept 2012} 

### Location Examples
* **GitHub repository** https://github.com/OuhscBbmc/RedcapExamplesAndPatterns {added Sept 2012}
* **File server directory** Ask your PI.  For Peds, it's typically on the "S" drive.
* **SQL Server Database** Ask Thomas, Will or David
* **REDCap database** Ask Thomas, Will or David.  It is a http url, and we're trying not to publicize its value.
* **ODBC UserDsn** The name depends on your specific repository, and SQL Server database.  Ask Thomas, Will or David for how to set it up.

### Installation (possible troubleshooting)
* **Git**: Will Beasley resorted to this workaround Sept 2012: http://stackoverflow.com/questions/3431361/git-for-windows-the-program-cant-start-because-libiconv2-dll-is-missing.  And then he copied the following four files from `D:/Program Files/msysgit/mingw/bin/` to `D:/Program Files/msysgit/bin/`: (1) `libiconv2.dll`, (2) `libcurl-4.dll`, (3) `libcrypto.dll`, and (4) `libssl.dll`. (If you install to the default location, you'll  move instead from `C:/msysgit/mingw/bin/` to `C:/msysgit/bin/`) {added Sept 2012}
* **Git**: On a different computer, Will Beasley couldn't get RStudio to recognize msysGit, so installed the `Full installer for official Git for Windows 1.7.11` from (http://code.google.com/p/msysgit/downloads/list) and switched the Git Path in the RStudio Options. {added Sept 2012}
* **RStudio** If something goes wrong with RStudio, re-installing might not fix the issue, because your personal preferences aren't erased.  To be safe, you can be thorough and delete the equivalent of `C:\Users\wibeasley\AppData\Local\RStudio-Desktop\`.  The options settings are stored (and can be manipulated) in this extentionless text file: `C:\Users\wibeasley\AppData\Local\RStudio-Desktop\monitored\user-settings\user-settings`. {added Sept 2012}

