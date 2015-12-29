rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
library(random, quietly=TRUE)
#Fixes Issue #144, in combination with HashUtility.R

#It's recommended that the salt is at least as long as the hash: http://crackstation.net/hashing-security.htm#salt
characterCount <- 44
# characterCountQuartered <- characterCount / 4

hashLengthInBits <- 256
valuesInHash <- 2 ^ hashLengthInBits
valuesInSalt <- (26+26+10) ^ characterCount

valuesInSalt > valuesInHash     #Check that this is true before continuing.  

# randomNumbers()
# randomSequence()
strings <- randomStrings(n=4, len=characterCount / 4, digits=T, upperalpha=T, loweralpha=T) #There's a limit of 20 for 'len'.
singleString <- paste0(strings, collapse="")
singleString
nchar(singleString)


#Now paste 'singleString' into the Security.tblUri, in the 'RecruitingSalt' row.