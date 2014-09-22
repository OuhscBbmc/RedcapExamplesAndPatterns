# #These first few lines run only when the file is run in RStudio,
# #   !!NOT when and Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

## @knitr LoadPackages
############################

library(knitr, quietly=TRUE)
library(ggplot2, quietly=TRUE)
library(Rcpp, quietly=TRUE)
library(RCurl, quietly=TRUE)
library(plyr, quietly=TRUE)
library(lubridate, quietly=TRUE)
library(stringr, quietly=TRUE)
library(RODBC, quietly=TRUE)

## @knitr DeclareGlobalFunctions
############################

CreatePsychopathResponseBarGraph <- function( characteristic = '', gender = '', labelMain='', labelX='', labelY='' ) {
  gCunningManipulative <- ggplot(data=demods, aes_string(x=characteristic, fill=gender))
  gCunningManipulative <- gCunningManipulative  + geom_bar(width = .5) + coord_flip()
  gCunningManipulative <- gCunningManipulative + labs( title = labelMain, x = labelX, y= labelY)
  gCunningManipulative
  return( gCunningManipulative )
}

## @knitr LoadDS
############################
############################

# { #This bracket permits the 'else' clause (because it's located on the top layer of the code.)
#   if( basename(getwd()) == "RedcapExample" )
#     pathDirectoryCode <- file.path(getwd(), "Dal", "DemoPsychopathExtractor.R")
#   else if( basename(getwd()) == "PsychopathDemo" )
#     pathDirectoryCode <- file.path(dirname(dirname(getwd())), "Dal", "DemoPsychopathExtractor.R")
#   else
#     stop(paste0("The working directory '", basename(getwd()),"' was not anticipated.  Please go near the top of the 'DemoSurvey' code and add this new location."))
# }

pathDirectoryCode <- "./Dal/DemoPsychopathExtractor.R"

if( !file.exists(pathDirectoryCode) ) stop(paste0("The file '", pathDirectoryCode, "' could not be found.  Check the path.  For this to work correctly, the '*.Rproj' needed to be opend in RStudio.  Otherwise the working directory won't be set correctly."))
source(pathDirectoryCode)
if( is.null(demods) ) stop("The extracting code did not run properly.  The data.frame 'demods' should not be null.")

rm(pathDirectoryCode)


## @knitr Gender
############################

gGender <- ggplot(data=demods, aes(factor(Gender))) + coord_flip()
gGender <- gGender + geom_bar(width=.5, fill="white", colour="red")
gGender <- gGender + geom_text(stat="bin", aes(label=..count..), color="tomato", size=6)
gGender <- gGender + labs( title = "Gender of Survey Respondents ", x = "", y="")
gGender

## @knitr PsychopathCharacteristics
############################

CreatePsychopathResponseBarGraph( characteristic = 'CunningManipulative', gender = 'Gender', labelMain="Cunning/Manipulative Behavior", labelX = "Level of Applicability", labelY = "Count")
CreatePsychopathResponseBarGraph( characteristic = 'LackOfRemorse', gender = 'Gender', labelMain="Lack of Remorse Characteristic", labelX = "Level of Applicability", labelY = "Count")
CreatePsychopathResponseBarGraph( characteristic = 'ParasiticLifestyle', gender = 'Gender', labelMain="Parasitic Lifestyle", labelX = " ", labelY = "Count")
CreatePsychopathResponseBarGraph( characteristic = 'CriminalVersatility', gender = 'Gender', labelMain="Criminal Versatility Behavior", labelX = " ", labelY = "Count")


## @knitr JuvenileDelinquency
############################

JuvenileDelinquencyNames <- c("Never", "Lunch Detention", "In-School Suspension", "Out-of-School Suspension", "Traffic Violations", 
                        "Multiple Law Enforcement Encounters", "On Probation")

NeverCount <- sum(demods$Never)
LunchDetentionCount <- sum(demods$LunchDetention)
InSchoolSuspensionCount <- sum(demods$InSchoolSuspension)
OutOfSchoolSuspensionCount <- sum(demods$OutOfSchoolSuspension)
TrafficViolationsCount <- sum(demods$TrafficViolations)
MultipleLawEnforcementEncountersCount <- sum(demods$MultipleLawEnforcementEncounters)
OnProbationCount <- sum(demods$OnProbation)

JuvenileDelinquencyType <- c(NeverCount, LunchDetentionCount, InSchoolSuspensionCount,
                     OutOfSchoolSuspensionCount, TrafficViolationsCount, MultipleLawEnforcementEncountersCount,
                     OnProbationCount)

Delinquency <- as.data.frame(list(jdnames=JuvenileDelinquencyNames, jdtype=JuvenileDelinquencyType))

gDelinquency <- ggplot(Delinquency, aes(x=jdnames, y=jdtype)) + coord_flip()
gDelinquency <- gDelinquency + geom_bar(stat="identity", fill="grey80", colour = "red")
gDelinquency <- gDelinquency + geom_text(stat="identity", aes(label=JuvenileDelinquencyType), color="tomato", size=6)
gDelinquency <- gDelinquency + theme_bw() + scale_x_discrete(drop=F)
gDelinquency <- gDelinquency + labs(x = '', y = '', title = 'Type of Juvenile Delinquency')
gDelinquency

## @knitr LongTermGoals
############################

demods$LackOfRealisticGoals <- as.numeric(demods$LackOfRealisticGoals)

gLongTermGoals <- ggplot(data=demods, aes(x=Gender, y = LackOfRealisticGoals)) + coord_flip()
gLongTermGoals <- gLongTermGoals + geom_boxplot(aes(fill=Gender))
gLongTermGoals <- gLongTermGoals + labs(title = "Boxplots of Realistic Long-Term Goal Rating", x = "", y = "Rating")
gLongTermGoals

## @knitr PsychopathicScoreAndLackOfRealisticGoals
############################
#TODO: maybe change this to two continuous variables so we can fit a smoother through it.

g <- ggplot(data=demods, aes_string(x="PsychopathicScore", y ="LackOfRealisticGoals", color="Gender")) 
g <- g + geom_point(position = position_jitter(w=1))
g <- g + geom_smooth(aes_string(group="Gender"), method="lm")
# gLongTermGoals <- gLongTermGoals + geom_boxplot(aes(fill=Gender))
# gLongTermGoals <- gLongTermGoals + labs(title = "Boxplots of Realistic Long-Term Goal Rating", x = "", y = "Rating")
g
rm(g)
