Extractor
================

## Summary
Exports/pulls REDCap data to R, and lightly munge, such as 

 * calculate timespans,
 * convert categories levels into factors, and
 * clean up missing values.
 * It is called by reports and sanitizers
 
## Notes
* In some ways, it's Fowler's (2002) Table Module.  However, it flows only *from* the server; it's not able to write data to the REDCap server.

## Examples
 * [NutmegExtractor](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/Dal/NutmegExtractor.R)
 