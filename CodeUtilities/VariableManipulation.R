#This seemed like the best place to put this code for now.  It probably deserves to be in some package.

ReplaceNAsWithFactorLevel <- function( scores, newNALabel="Unknown", addUnknownLevel=FALSE) {
  if( addUnknownLevel ) {
    levels(scores) <- c(levels(scores), newNALabel)  #Add a new level called 'Unknown', or whatever the caller specified
  }
  
  scores[is.na(scores)] <- newNALabel #eg, "Unknown"
  if( any(is.na(scores)) ) stop("The reassigned factor variable should not have any NA values.")
  return( scores )
}
