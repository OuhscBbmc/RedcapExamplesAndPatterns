This document is a collection of guidelines, practices & patterns that I'd like for us to be consistent about for the code in our projects.
 
### Variables
1. **Missing** values in a continuous variable should be represented as `NA`. {Oct 28, 2012}
1. **Missing** values in factor variables should be represented as another level called '`Unknown`' (eg, `ds$sex <- factor(ds$sex, levels=0:2, labels=c("Female", "Male", "Unknown"))`).  There should be no `NA` values remaining in a factor variable.  Assign them to a level like `ds$sex[is.na(ds$sex)] <- "Unknown"` {Oct 28, 2012}

### Variable Naming
1. When the REDCap database has already established a name, try to follow that style. {Oct 28, 2012}
1. When possible use no underscores, and capitalize the first letter of each word (eg, RaceBlack, RaceWhite.) {Oct 28, 2012}
1. Acronyms that are three or more letters are capitalized like a real word (eg, GedMale, HSDiplomaMale) {Oct 28, 2012}