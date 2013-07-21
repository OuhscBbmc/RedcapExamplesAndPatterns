## Setting up the R and REDCap project on a new development computer
### Installation (required)
The order matters. 

1. **[R](http://cran.r-project.org/)** is the centerpiece of the analysis. Every few months, you'll need to download the most recent version.  {added Sept 2012}
                                     
1. **[RStudio Desktop](http://www.rstudio.com/ide/download/desktop)** is the IDE (integrated design interface) that you'll use to interact with R, GitHub, Markdown, and LaTeX. Updates can be checked easily through the menus `Help` -> `Check for updates`.   {added Sept 2012}
1. **Several R Packages** will need to be installed. Running the R script [`PackageInstallation.R`](https://github.com/OuhscBbmc/RedcapApiExample/blob/master/CodeUtilities/PackageInstallation.R) (located in the `CodeUtilities` directory) downloads and installs only the packages that aren't already on your computer.  Create a new 'personal library' if it prompts you.  The script also updates existing packages if a newer version is available.  The list of packages will grow as we develop the reports.  Help keep the list updated. {added Sept 2012}
1. **Several R Packages** might need to be updated.  Unless you've been told not to (because it would break something -this is rare), periodically update the packages by executing the following code `update.packages(ask="graphics", checkBuilt=TRUE)`. {added Sept 2012}
1. **[GitHub](https://github.com/)** registration is necessary to push modified files to the repository.    First, register a free user account at https://github.com/plans.  Then tell the repository owner your exact username, and they'll add you as a collaborator to our GitHub repository (eg, https://github.com/OuhscBbmc/RedcapApiExample). {added Sept 2012}
1. **[GitHub for Windows Client](http://windows.github.com/)** does the basic tasks a little easier the git features built into RStudio.  {added Oct 2012}
                              
### Installation (optional)
The order does not matter.
* **[msysGit](http://msysgit.github.com/)** allows RStudio to track changes and commit & sync them to the GitHub server. Connect RStudio to GitHub repository.  I moved this to optional (Oct 14, 2012) because the GitHub client (see above) does almost everything that the RStudio plugin does; and it does it a little better and a little more robust; and its installation hasn't given me problems.  {added Oct 2012}
  * Starting in the top right of RStudio, click: Project -> New Project -> Create Project from Version Control -> Git  {added Sept 2012}
  * An example of a repository URL is https://github.com/OuhscBbmc/RedcapApiExample. Specify a location to save (a copy of) the project on your local computer.  {added Sept 2012}

* **[Notepad++](http://notepad-plus-plus.org/)** lets you look at the raw CSV text when I'm troubleshooting issues (instead of looking at the file through Excel, which masks & causes some issues).  {added Sept 2012}
* **[MiKTeX](http://miktex.org/)** is necessary only if you're using Sweave or knitr to produce *LaTeX* files (and not just *markdown* files).  It's a huge, slow installation that can take an hour or two.  {added Sept 2012}
* **[GitHub for Eclipse](http://eclipse.github.com/)** is something I discourage for a beginner, and I strongly recommend you start with RStudio (and [GitHub Client](http://windows.github.com/) or the git capabilities within RStudio) for a few months before you even consider Eclipse.  It's included in this list for the sake of completeness. When installing EGit plug-in, ignore eclipse site and check out this youtube video:http://www.youtube.com/watch?v=I7fbCE5nWPU.
* **[Color Oracle](http://colororacle.org/)** simulates the three most common types of color blindness.  If you have produce a color graph in a report you develop, check it with Color Oracle (or ask someone else too).  If it's already installed, it takes less than 10 second to check it against all three types of color blindness. If it's not installed, extra work may be necessary if Java isn't already installed.  When you download the zip, extract the `ColorOracle.exe` program where you like. {added Sept 2012}
* **[pandoc](http://johnmacfarlane.net/pandoc/)** converts files from one markup format into another.  We'll possibly use this to create tables in MS Word (for article submissions). {added Sept 2012} 

### Location Examples
* **GitHub repository** https://github.com/OuhscBbmc/RedcapApiExample {added Sept 2012}
* **File server directory** Ask your PI.  For Peds, it's typically on the "S" drive.
* **SQL Server Database** Ask Thomas, Will or David
* **REDCap database** Ask Thomas, Will or David.  It is a http url, and we're trying not to publicize its value.
* **ODBC UserDsn** The name depends on your specific repository, and SQL Server database.  Ask Thomas, Will or David for how to set it up.

### Installation (possible troubleshooting)
* **Git**: Will Beasley resorted to this workaround Sept 2012: http://stackoverflow.com/questions/3431361/git-for-windows-the-program-cant-start-because-libiconv2-dll-is-missing.  And then he copied the following four files from `D:/Program Files/msysgit/mingw/bin/` to `D:/Program Files/msysgit/bin/`: (1) `libiconv2.dll`, (2) `libcurl-4.dll`, (3) `libcrypto.dll`, and (4) `libssl.dll`. (If you install to the default location, you'll  move instead from `C:/msysgit/mingw/bin/` to `C:/msysgit/bin/`) {added Sept 2012}
* **Git**: On a different computer, Will Beasley couldn't get RStudio to recognize msysGit, so installed the `Full installer for official Git for Windows 1.7.11` from (http://code.google.com/p/msysgit/downloads/list) and switched the Git Path in the RStudio Options. {added Sept 2012}
* **RStudio** If something goes wrong with RStudio, re-installing might not fix the issue, because your personal preferences aren't erased.  To be safe, you can be thorough and delete the equivalent of `C:\Users\wibeasley\AppData\Local\RStudio-Desktop\`.  The options settings are stored (and can be manipulated) in this extentionless text file: `C:\Users\wibeasley\AppData\Local\RStudio-Desktop\monitored\user-settings\user-settings`. {added Sept 2012}

