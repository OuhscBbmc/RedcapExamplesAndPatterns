Ellis
================

## Summary

Resembles Ellis Island 100 years ago.  Welcomes visitors into the country and encourages them to contribute to the melting pot, but only after a dehumanizing de-lousing.

* Moves external data (eg, sent from OSDH) to SQL Server, where it is audit-able.
* Read CSV into R.
* Verify structure is the same as the previous import.
* Lightly munge.

## Notes
 * A specialized form of [ETL](https://en.wikipedia.org/wiki/Extract,_transform,_load) (extract, transfer, & load).
 * There's no attempt to apply a real treatment.  If something a dataset is unfit to enter our domain, it's rejected.
 * From Wikipedia, "Ellis Island, in Upper New York Bay, was the gateway for millions of immigrants to the United States as the nation's busiest immigrant inspection station from 1892 until 1954."
 * Usually followed by a `Ferry` pattern.
 * Since the reading & writing is faster in a database's normalized table than in REDCap's EAV table, we SQL Server as a way station.  There's nothing special about SQL Server, and PostgreSQL and MySQL should be acceptable alternatives (assuming they're connected through LDAP).


## Examples
 