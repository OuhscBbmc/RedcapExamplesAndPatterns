## Setting up the R and REDCap project on a new development computer
### Installation (required)
The order matters.

1. **[R](http://cran.r-project.org/)** is the centerpiece of the analysis. Every few months, you'll need to download the most recent version.  {added Sept 2012}

1. **[RStudio Desktop](http://www.rstudio.com/ide/download/desktop)** is the IDE (integrated design interface) that you'll use to interact with R, GitHub, Markdown, and LaTeX. Updates can be checked easily through the menus `Help` -> `Check for updates`.   {added Sept 2012}
1. **Dozens of R Packages** will need to be installed.  Choose between one of the two related scripts.  It will install [from our list of packages that our data analysts typically need](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/utility/package-dependency-list.csv).  The script installs a package only if it's not already installed; also an existing package is updated if a newer version is available.  Create a new 'personal library' if it prompts you.  It takes at least thirty minutes, so start it before you go to lunch.  The list of packages will evolve over time, so please help keep the list updated.  {added Sept 2012}   
    1. Run the online [Gist](https://gist.github.com/wibeasley/2c5e7459b88ec28b9e8fa0c695b15ee3) file, which is the easiest option for begninners.  Just three lines are needed.  The first installs an important package, the second defines the `package_janitor_remote()` function, and the third calls the function (and passes a specific CSV of packages).
        ```r
        if( !base::requireNamespace("devtools") ) utils::install.packages("devtools")
        devtools::source_gist("2c5e7459b88ec28b9e8fa0c695b15ee3", filename="package-janitor-bbmc.R")
        package_janitor_remote("https://raw.githubusercontent.com/OuhscBbmc/RedcapExamplesAndPatterns/master/utility/package-dependency-list.csv")
        
        ````
    1. Run the local R script [`install-packages.R`](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/utility/install-packages.R) (located in the `utility/` directory) that lives in this repository.
1. **Several R Packages** might need to be updated.  Unless you've been told not to (because it would break something -this is rare), periodically update the packages by executing the following code `update.packages(ask="graphics", checkBuilt=TRUE)`. {added Sept 2012}
1. **[GitHub](https://github.com/)** registration is necessary to push modified files to the repository.    First, register a free user account at https://github.com/plans.  Then tell the repository owner your exact username, and they'll add you as a collaborator  (eg, to https://github.com/OuhscBbmc/RedcapExamplesAndPatterns). {added Sept 2012}
1. **[GitHub for Windows Client](http://windows.github.com/)** does the basic tasks a little easier the git features built into RStudio.  {added Oct 2012}

### Installation (recommended)
The order does not matter.     

* **[ODBC Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server)** is for connecting to the [token server](https://github.com/OuhscBbmc/REDCapR/blob/master/vignettes/SecurityDatabase.Rmd), if your institution is using one.  As of this writing, version 17 is the most recent driver version.  See if a new one exists. {updated Apr 2018}
* **[R Tools for Windows](https://cran.r-project.org/bin/windows/Rtools/)** is necessary to build some packages in development hosted on GitHub. {added Feb 2017}
* **[Notepad++](http://notepad-plus-plus.org/)** is a text editor that allows you look at the raw text files, such as code and CSVs.  For CSVs and other data files, it's helpful when troubleshooting (instead of looking at the file through Excel, which masks & causes some issues).  {added Sept 2012}
* **[Atom](https://atom.io/)** is a text editor, similar to Notepad++.  Notepad++ appears more efficient opening large CSVs.  Atom is better suited when editing a lot of files in a repository.  For finding and replacing across a lot of files, it is superior to Notepad++ and RStudio; it permits regexes and has a great GUI preview of the potential replacements.  

    Productivity is enchanced with the following [Atom packages](https://atom.io/packages):

    1. [Sublime Style Column Selection](https://atom.io/packages/Sublime-Style-Column-Selection): Enable Sublime style 'Column Selection'. Just hold 'alt' while you select, or select using your middle mouse button.
    1. [atom-language-r](https://atom.io/packages/atom-language-r) allows Atom to recognize files as R.  This prevents spell checking indicators and enable syntax highlighting.  When you need to browse through a lot of scattered R files quickly, Atom's tree panel (on the left) works well.  An older alternative is [language-r](https://atom.io/packages/language-r).
    1. [language-csv](https://atom.io/packages/language-csv): Adds syntax highlighting to [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) files.  The highlighting is nice, and it atomatically disables spell checking lines.
    1. [atom-beautify](https://atom.io/packages/atom-beautify): Beautify HTML, CSS, JavaScript, PHP, Python, Ruby, Java, C, C++, C#, Objective-C, CoffeeScript, TypeScript, Coldfusion, SQL, and more in Atom.
    1. [atom-wrap-in-tag](https://atom.io/packages/atom-wrap-in-tag): wraps tag around selection; just select a word or phrase and hit Alt + Shift + w.
    1. [minimap](https://atom.io/packages/minimap): A preview of the full source code (in the right margin).
    1. [script](https://atom.io/packages/script): Run scripts based on file name, a selection of code, or by line number.
    1. [git-plus](https://atom.io/packages/git-plus): Do git things without the terminal (I don't think this is necessary anymore).

    The packages can be installed through Atom, or through the `apm` utility in the command line:

    ```bash
    apm install sublime-style-column-selection atom-language-r language-csv atom-beautify atom-wrap-in-tag minimap script
    ```

    And the following settings keep files consistent among developers.

    1. File | Settings | Editor | Tab Lenght: 2 (As opposed to 3 or 4, used in other conventions)
    1. File | Settings | Editor | Tab Type: soft (This inserts 2 spaces instead of a tab when 'Tab' is pressed)

* **[SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)** is an easy way to access the database and write queries (and transfer the SQL to an R file).   It's not required for the REDCap API, but it's usually necessary when integrating REDCap with other databases.

    Note: here are some non-default changes that faciliate our workflow.  The first two help when we save the database *structure* (not data) on GitHub, so we can easily track/monitor the structual changes over time.    The *tabs* options keeps things consistent between editors.  In the SSMS 'Tools | Options' dialog box:
    1. 'SQL Server Object Explorer' | 'Scripting' | 'Include descriptive headers': False
    1. 'SQL Server Object Explorer' | 'Scripting' | 'Script extended properties': False
    1. 'Text Editor' | 'All Languages' | 'Tabs' | 'Tab size': 2
    1. 'Text Editor' | 'All Languages' | 'Tabs' | 'Indent size': 2
    1. 'Text Editor' | 'All Languages' | 'Tabs' | 'Insert Spaces': selected
    
    These don't affect the saved files, but make life easier.  The first makes the [result font bigger](https://blog.sqlauthority.com/2016/05/31/sql-server-ssms-tip-get-larger-fonts-results-grid-output/).
    1. 'Environment' | 'Fonts and Colors' | 'Show settings for: Grid Results' | 'Size': 10
    1. 'Query Results' | 'SQL Server' | 'Results to Grid' | 'Include column headers when copying or saving the results': checked
    1. 'Designers' | 'Table and Databas Designers' | 'Prevent saving changes that require table-recreation': unchecked
    
    1. 'Text Editor' | 'Editor Tab and Status Bar' | 'Tab Text' | 'Include Server Name': false
    1. 'Text Editor' | 'Editor Tab and Status Bar' | 'Tab Text' | 'Include Database Name': false
    1. 'Text Editor' | 'Editor Tab and Status Bar' | 'Tab Text' | 'Include Login Name': false
    1. 'Text Editor' | 'Transact-SQL' | 'General' | 'Line Numbers': true

    For more details, see [setting-up-dev-machine.md](https://github.com/OuhscBbmc/bbmc-database-management/blob/master/maintenance/setting-up-server/setting-up-dev-machine.md) (in a private repo that's restricted to BBMC members).

* **[Pulse Secure](https://connect.ouhsc.edu)** is VPN client for OUHSC researchers.  It's not required for the REDCap API, but it's usually necessary to communicate with other campus data sources.

### Installation (optional)
The order does not matter.

* **[msysGit](http://msysgit.github.com/)** allows RStudio to track changes and commit & sync them to the GitHub server. Connect RStudio to GitHub repository.  I moved this to optional (Oct 14, 2012) because the GitHub client (see above) does almost everything that the RStudio plugin does; and it does it a little better and a little more robust; and its installation hasn't given me problems.  {added Oct 2012}
  * Starting in the top right of RStudio, click: Project -> New Project -> Create Project from Version Control -> Git  {added Sept 2012}
  * An example of a repository URL is https://github.com/OuhscBbmc/RedcapExamplesAndPatterns. Specify a location to save (a copy of) the project on your local computer.  {added Sept 2012}

* **[MiKTeX](http://miktex.org/)** is necessary only if you're using knitr or Sweave to produce *LaTeX* files (and not just *markdown* files).  It's a huge, slow installation that can take an hour or two.  {added Sept 2012}
* **[CSVed](http://csved.sjfrancke.nl/)** is a lightweight program for viewing data files.  It fits somewhere between a text editor and Excel.
* **[LibreOffice Calc](https://www.libreoffice.org/discover/calc/)** is an alternative to Excel.  Unlike it Excel, it doesn't guess much with formatting (which usually mess up things, especially dates).
* **[Visual Studio Code](https://code.visualstudio.com/)** is an extensible text editor that runs on Windows and Linux, similar to [Atom](https://atom.io/) (described above).  It's much [lighter](https://stackoverflow.com/questions/30527522/what-are-the-differences-between-visual-studio-code-and-visual-studio) than the full [Visual Studio](https://visualstudio.microsoft.com/).  Like Atom, it supports browsing through the directory structure, replacing across files, interaction with git, and previewing markdown.  Currently, it supports searching CSVs better than Atom.  Productivity is enchanced with the following extensions:  {added Dec 2018}
    * [Excel Viewer](https://marketplace.visualstudio.com/items?itemName=GrapeCity.gc-excelviewer) isn't a good name, but I've liked the capability.  It displays CSVs and other files in a grid. {added Dec 2018}
    * [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv) color codes the columns, but still allows you to see and edit the raw plain-text file. {added Dec 2018}
    * [SQL Server](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) allows you to execute against a database, and view/copy/save the grid results.  It doesn't replicate all SSMS features, but is nice as your scanning through files. {added Dec 2018}
    * [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) produces  green squiggly lines under words not in its dictionary.  You can add words to your user dictionary, or a project dictionary.
 * **[SourceTree](http://www.sourcetreeapp.com/)** is a rich client that has many more features than the GitHub client.  I don't recommend it for beginners, since it has more ways to mess up things.  But for developers, it nicely fills a spot in between the GitHub client and command-line operations.  The branching visualization is really nice too. Unfortunately and ironically, it doesn't currently support Linux. {added Sept 2014}.
* **[git-cola](http://git-cola.github.io/)** is probably the best GUI for Git supported on Linux.  It's available through the official [Ubuntu repositories](http://packages.ubuntu.com/search?keywords=git-cola) with `apt-get` (also see [this](https://apps.ubuntu.com/cat/applications/git-cola/)).  The branch visualization features are in a different, but related program, 'git dag'.  {added Sept 2014}
* **[GitHub for Eclipse](http://eclipse.github.com/)** is something I discourage for a beginner, and I strongly recommend you start with RStudio (and [GitHub Client](http://windows.github.com/) or the git capabilities within RStudio) for a few months before you even consider Eclipse.  It's included in this list for the sake of completeness. When installing EGit plug-in, ignore eclipse site and check out this youtube video:http://www.youtube.com/watch?v=I7fbCE5nWPU.
* **[Color Oracle](http://colororacle.org/)** simulates the three most common types of color blindness.  If you have produce a color graph in a report you develop, check it with Color Oracle (or ask someone else too).  If it's already installed, it takes less than 10 second to check it against all three types of color blindness. If it's not installed, extra work may be necessary if Java isn't already installed.  When you download the zip, extract the `ColorOracle.exe` program where you like. {added Sept 2012}
* **[pandoc](http://johnmacfarlane.net/pandoc/)** converts files from one markup format into another.  We'll possibly use this to create tables in MS Word (for article submissions). {added Sept 2012}
* **Ubuntu** desktop 17.04 follows [these instructions](https://askubuntu.com/a/862520/153921) for the R and RStudio and required these debian packages to be installed before the R packages.

    ```sh
    # Git
    sudo apt-get install git-core
    git config --global user.email "wibeasley@hotmail.com"
    git config --global user.name "Will Beasley"
    git config --global credential.helper 'cache --timeout=3600000'

    # The 'xml2' package:
    sudo apt-get install libxml2-dev r-cran-xml

    # The 'curl' package, and others
    sudo apt-get install libssl-dev libcurl4-openssl-dev

    # The 'udunits2' package: https://cran.r-project.org/web/packages/udunits2/index.html
    sudo apt-get install libudunits2-dev

    # The 'odbc' package: https://github.com/r-dbi/odbc#linux---debian--ubuntu
    sudo apt-get install unixodbc-dev tdsodbc odbc-postgresql libsqliteodbc

    # The 'rgl' package
    sudo apt-get install libcgal-dev libglu1-mesa-dev libglu1-mesa-dev

    # The 'magick' package
    sudo apt-get install 'libmagick++-dev'

    # The 'pdftools' and 'Rpoppler' packages, which involve PDFs
    sudo apt-get install libpoppler-cpp-dev libpoppler-glib-dev

    # The 'sys' package
    sudo apt-get install libapparmor-dev

    # Some package I forgot, maybe 'svglite'
    sudo apt-get install libcairo2-dev

    # 'rJava' and others
    sudo apt-get install default-jre default-jdk
    sudo R CMD javareconf
    sudo apt-get install r-cran-rjava

    # The 'sf' and other spatial packages: https://github.com/r-spatial/sf#ubuntu
    sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
    sudo apt-get update
    sudo apt-get install libudunits2-dev libgdal-dev libgeos-dev libproj-dev libgeos++-dev

    # For databases
    sudo apt-get install sqlite sqliteman
    sudo apt-get install postgresql postgresql-contrib pgadmin3
    ```


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
