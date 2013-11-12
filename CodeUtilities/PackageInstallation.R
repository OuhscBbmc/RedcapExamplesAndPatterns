#This code checks the user's installed packages against a list of packages (that we've manually compiled) 
#   necessary for our 'MReporting' repository to be fully operational. Missing packages are installed, while existing packages are not.
#   If anyone sees a package that should be on there, please tell me.
rm(list=ls(all=TRUE)) #Clear the memory for any variables set from any previous runs.

packagesToInstall <- c(
  "car" #Accompanies Fox, J. and Weisberg, S., An R Companion to Applied Regression,
  , "classInt" #Choosing univariate class intervals for mapping or other graphics purposes
  , "colorspace" #Explicit control over the HCL color scheme
  , "devtools" #Used in the C1 survival for sourcing gists
  , "digest" #Creates SHA hashes for the recruiting database
  , "evaluate" #A package that Hadley et al use a lot in their packages.  It helps when things are passed by reference.
  , "foreign" #Reads data in other formats
  , "ggplot2" #Graphing
  , "ggthemes" #Extra themes, scales and geoms for ggplot
  , "googleVis" #JavaScript-based visualizations, like scrollable tables
  , "ggmap" #Maps & graphics, based on ggplot
  , "knitr" #For reporting
  , "lme4" #Multilevel models
  , "lubridate" #Consistent/convienent function signatures for manipulating dates
  , "modeest" #Estimating the mode of unimodal distributions
  , "plyr" #Important for most of our data manipulation
  , "R2OpenBUGS" #Interact with the Bayesian modeling software, OpenBugs
  , "R2WinBUGS" #Interact with the Bayesian modeling software, WinBugs
  , "random" #Creates random numbers for salts
  , "RColorBrewer" #Explicit control over the Color Brewer colors.  See http://colorbrewer2.org/
  , "Rcpp" #Optimizing some intensive functions
  , "RCurl" #Interact with the REDCap API
  , "reshape2" #Data manipulation not covered in plyr
  , "rjags" #Interact with the Bayesian modeling software, JAGS
  , "RODBC" #For connecting to ODBC databases
  , "sp" #Spatial analysis
  , "spdep" #Spatial dependence; builds on 'sp', "xtable" #Creates formatted tables. Especially nice for LaTeX
  , "stringr" #Consistent/convienent function signatures for manipulating text
<<<<<<< HEAD
  , "testit" #Light testing framework, includes useful `assert()` function.
  , "testthat" #Heavy testing framework
=======
  , "testit" #has the useful `assert()` function
>>>>>>> 6d4b9b475ab991e1788be5d94023224a737dccde
  , "tm" #Text Mining
  , "wordcloud" #Creating the graphics of word frequencies  
  , "xtable" #Formats tables, especially for LaTeX output.
  , "zipcode" #Database of zipcodes and their lat & long; also useful for flagging bad zipcodes
) 

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