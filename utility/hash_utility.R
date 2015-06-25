# We recommend using a 44 character salt, each with 66(=26+26+10) possible values.  
# This creates 10^78 possible values, which is more than the 10^77 (=2^256) possible values 
# in the SHA256 hash encryption algorithm.  This inequality was recommended by 
# [this page]( http://crackstation.net/hashing-security.htm#salt), and others.  Salting hashes
# helps protect againsts dictionary attacks: http://en.wikipedia.org/wiki/Dictionary_attack
# 
# The package [`random`](http://cran.r-project.org/web/packages/random) is used to create true random numbers.  
#  It calls a webservice; the package was written & maintained by Dirk Eddelbuettel, who has some official and 
# semi-official affiliations with Debian and R Project.

HashAndSaltSha256 <- function( x, minLengthInclusive, maxLengthInclusive, requiredMode, saltToAdd ) {
  stopifnot(mode(x)==requiredMode)
  x <- ifelse(x==0, NA_integer_, x)
  stopifnot(all(is.na(x) | (minLengthInclusive<= str_length(x) & str_length(x)<=maxLengthInclusive) ))
  salted <- paste0(x, saltToAdd)
  hash <- digest::digest(object=salted, algo="sha256")
  return( ifelse(is.na(x), NA_character_, hash) )
}
