Record Set
================

## Summary

 * [Fowler (2012)](http://martinfowler.com/books/eaa.html) defines a Record Set as "an in-memory representation of tabular data"
 * Can mimic the structure of the database(s) the records are being read from and written to.
 * This allows the programming language (e.g., R, Python, Java, C#) to manipulate the records in more expressive ways than is possible in most databases with SQL.
 * Also, a statistician's existing R experience can be leveraged.

## Notes

In Fowler's terminology, the R `data.frame` is an "implicit interface", because it does not enforce the database's column names and data types.  The weakness was acceptable for the majority of our MIECHV CQI.  However in hindsight, we probably would have preferred to use a language that provided a Record Set with "explicit interface" for the manipulation related to determining and refreshing the recruiting pool.  The manipulation was complicated, and the data flow was stable enough to justify the extra structure and investment of a C# ADO.NET DataSet.  Python (using the SQLAlchemy or Django libraries) would likely have been superior as well for this task.

## Examples
