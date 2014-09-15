Ferry
================

## Summary
moves data from SQL Server to REDCap

 * eg, so recruiters view in REDCap, instead of SQL Server.
 * It’s a lot cheaper/quicker to set up a two-way bound interface in REDCap than in other databases.

## Notes
 * Usually preceded by an `Ellis` (Island Station) pattern.
 * Since the reading & writing is faster in a database's normalized table than in REDCap's EAV table, we SQL Server as a way station.  There's nothing special about SQL Server, and PostgreSQL and MySQL should be acceptable alternatives (assuming they're connected through LDAP).
 * Similar to Fowler's 'Data Mapper', except that the data mapper moves data between a database and *objects*, while this moves data between two databases.

## Examples
