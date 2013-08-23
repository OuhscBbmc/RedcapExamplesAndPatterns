#This code checks the user's installed packages against a list of packages (that we've manually compiled) 
#   necessary for our 'MReporting' repository to be fully operational. Missing packages are installed, while existing packages are not.
#   If anyone sees a package that should be on there, please tell me.
rm(list=ls(all=TRUE)) #Clear the memory for any variables set from any previous runs.

packagesToInstall <- c("RCurl" #For interacting with the REDCap API
                       , "RODBC" #For connecting to ODBC databases
                       , "knitr" #For reporting
                       , "ggplot2" #Graphing
                       , "ggthemes" #Extra themes, scales and geoms for ggplot
                       , "plyr" #Important for most of our data manipulation
                       , "reshape2" #data manipulation not covered in plyr (possibly not necessary anymore)
                       , "devtools" #CUsed in the C1 survival for sourcing gists
                       , "stringr" #Consistent/convienent function signatures for manipulating text
                       , "lubridate" #Consistent/convienent function signatures for manipulating dates
                       , "evaluate" #A package that Hadley et al use a lot in their packages.  It helps when things are passed by reference.
                       , "colorspace" #Explicit control over the HCL color scheme
                       , "RColorBrewer" #Explicit control over the Color Brewer colors.  See http://colorbrewer2.org/
                       , "Rcpp" #Optimizing some intensive functions
                       , "wordcloud" #Creating the graphics of word frequencies
                       , "tm" #Text Mining
                       , "digest" #Creates SHA hashes for the recruiting database
                       , "random" #Creates random numbers for salts
                       , "xtable" #Creates formatted tables. Especially nice for LaTeX
                       , "modeest" #Estimating the mode of unimodal distributions
                       ) 
#"devtools",

for( packageName in packagesToInstall ) {
  available <- require(packageName, character.only=TRUE) #Loads the packages, and indicates if it's available
  if( !available ) {
    install.packages(packageName, dependencies=TRUE)
    require( packageName, character.only=TRUE)
  }
}

update.packages(ask="graphics", checkBuilt=TRUE)

#There will be a warning message for every  package that's called but not installed.  It will look like:
#    Warning message:
#        In library(package, lib.loc = lib.loc, character.only = TRUE, logical.return = TRUE,  :
#        there is no package called 'bootstrap'
#If you see the message (either in here or in another piece of the project's code),
#   then run this again to make sure everything is installed.  You shouldn't get a warning again.