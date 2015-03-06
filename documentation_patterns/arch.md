Arch
================

## Summary

* Exports/pulls SQL Server data to R and lightly munge. 
* It's a one-way version of Fowler’s (2002) Table Gateway.
* It can be called by called by reports, table gateways, and other arches.

## Notes

The arch exports warehouse data (not REDCap data) to R and lightly munge.  Like the Extractor above, it a uni-directional version of Martin Fowler's "Table Data Gateway" (2002, p. 144).  The arch is typically called by reports, and other arches/gateways. ZZZ explain why we chose to differentiate the REDCap and SQL Server gateways ZZZ.  The three previous patterns are far from novel, and commonly called ETL code (extract, transform, and load), and do not require flowery names.  But emphasizing their distinctive features helps our developers communicate.

## Examples
 