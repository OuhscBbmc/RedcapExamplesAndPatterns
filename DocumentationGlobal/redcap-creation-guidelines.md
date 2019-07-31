---
title: REDCap Project Creation Guidelines
output:
  html_document:
    keep_md: yes
    toc: yes
---

# Motivation
This is a running list of tips and advice creating a REDCap project.  Many of these are guided by the following principles:

* Encourage users to enter the cleanest & most accurate data so that the downstream analyses will be the most useful.  Make it easy for them to do the right thing.
* Reduce the time & expense of maintaining a REDCap project over several years.
* If there is dirty data is entered, make is easy to detect later.  We want to avoid silent errors.
* Picking a pattern that's easy to apply to as many projects as possible.  If two conventions are equally good, pick one so that it's easy for members of the research team to contribute to multiple projects.

# Tips
Here's is our advice.  Within each category, they're listed in roughly descending order of importance.

### Keys and IDs
1. For `studyid`, use an auto-incrementing variable.  This variable is super important in later data manipulation, that we need it to be as clean as possible.  If you need a [natural key](https://en.wikipedia.org/wiki/Natural_key) (ie, not a [synthetic/surrogate/artificial key](https://en.wikipedia.org/wiki/Surrogate_key)), create a second variable to contain it.  {Added by Thomas & Will, 2015-10.}
1. For `studyid`, allow only positive & negative integers.  Use validation to prevent strings and floating-point numbers.  Negative numbers are useful for temporary/test subjects.  If you prevent them, the users are likely to use a positive integer that's harder to identify & evict later.  {Added by Thomas & Will, 2015-10.}
1. For `studyid`, use validation to prevent any integer above 2^31-1 (=2,147,483,647).  Otherwise, downstream programs (eg, R & SAS) might convert this to a floating-point variable, and you'll be unable to distinguish between values like `91234567890123452` and `91234567890123453` since they're both represented as `91234567890123456` floats.  (Notice the last decimal is lost.)

    As Thomas notes, this shouldn't be a problem if you're using an auto-incrementing integer for `studyid`.  As of 2014, every living Chinese citizen will still fit under 2^31.

    If it's too late and this has already happenned, 
    * Convert the REDCap variable to a character/string variable.
    * Fix the diluted values in REDCap.
    * Make sure the stats programs treat it as a character variable, instead of automatically converting it to a float or integer.
    {Added by Thomas & Will, 2015-10.}
    
### Outcome Variables
1. Validate and be as stingy as possible with every variable.  Where possible:
    * Use radio buttons for categorical variables.
    * Use validation to force dates/integers/numbers .
    * Use min & max values.
    * Avoid allowing null/empty values, because they're hard to account for in stat programs.  If a value is legitimately missing (eg, consider capturing that explicitly with a secondary variable).
    
    {Added by Thomas & Will, 2015-10.}

1. Variable names have fewer options than usual, because capital letters aren't allowed.  Analysis is easier if the variable names don't have to change.  Therefore, think how you'll later use them in R or Python.  
    * Pick a style guide.  For R, the current trend is towards [Hadley's](http://r-pkgs.had.co.nz/style.html) and [Google's](https://google.github.io/styleguide/Rguide.xml) conventions, and conveniently this works well with REDCap's prohibition of capital letters. {Added by Will, 2015-10.}
    * REDCap's wide format frequently has to be normalized (ie, converted from wide to tall).  This frequently requires regexes, so consider which names are most conveniently handled by a regex.  For example the collection (`iq_initial_age_2` ... `iq_year_5_age_12`) is less desirable than (`iq_year_0_age_02`...`iq_year_5_age_12`).  "Initial" has to be converted to a number, and because `age_2` isn't padded to `age_02`, you might have to brush up on greedy, lazy, and possessive regex matches. {Added by Will, 2015-10.}

### SQL Fields

Here's a quick example of the SQL code underneath a SQL lookup field.  This scenario has two REDCap projects.  In the main ('child') project, each record is a CPS referral; each referral record references the assigned CPS worker.  In the 'parent' project, each record is one of ~100 DHS worker; a portion includes the ~20 CPS workers; the parent project essentially serves as a lookup table to the main/child project.  The dropdown in the main/child project should present only the 20 CPS workers (and not rely on the user to know who is CPS and who is non-CPS).

Notice the `redcap_data`  is joined to itself (with aliases `a` and `b`).  The `a` table retrieves the parent values that will be stored in the child projects; the `b` table is used so only CPS workers are shown, and not any non-CPS workers (the numeric value for a CPS worker in the parent project is '1').

The SELECT clause should have two columns.  The first value will be stored in the child project; the second will be presented in the dropdown box.  It can be arbitrarily complex; many times we'll LEFT JOIN a `c` table for the sake of presenting additional context to the user when selecting from the dropdown box.

```sql
SELECT
  a.record,
  a.value
FROM redcap_data a
  LEFT JOIN redcap_data b ON
    (a.project_id = b.project_id)
    AND
    (a.record = b.record)
    AND
    (a.event_id = b.event_id)
WHERE
  (a.project_id = 666)                -- the REDCap pid for the parent/provider project
  AND
  (a.field_name = 'provider_name')
  AND
  (b.field_name = 'provider_role')
  AND
  (b.value = '1')                     -- the provider code for 'cps worker'
ORDER BY a.value
```

Thomas is good about thinking through the interface from the user's perspective, and therefore frequently adds additional links to an item's 'Field Label'.  For example, these two links allow the user to quickly jump to the parent project.  If the user has privileges in the parent project, they'll be able to read and/or modify the records.  Consider granting privileges to the parent project to only a subset of well-trained users (and not to all users) because their mistakes could mess up a bunch of new and existing records/pointers in the child project.

```html
<font size = "1" color="purple">
  Click the links below to go to the provider project to add or modify the worker/supervisor provider information.
</font>

<a href="https://bbmc.ouhsc.edu/redcap/redcap_v6.1.2/DataEntry/index.php?pid=666&page=provider_information">
  Add a New Provider
</a>

<a href="https://bbmc.ouhsc.edu/redcap/redcap_v6.1.2/DataExport/index.php?pid=666&report_id=1017">
  Find and Modify Provider Info
</a>
```
Finally, REDCap is frequently adding new capabilities, including some complex features that combine sql lookup fields and smart variables.  Consult  Thomas if there's something you are facing constraints with the features mentioned above. {Added 2019-07}

### Reports, Media, Surveys, Whatever
{Create a category and add bullets when you think of some.}

### API
1. Use a library like [REDCapR](https://github.com/OuhscBbmc/REDCapR), [PhpCap](https://github.com/aarenson/PhpCap), or any of the others listed on [this page](https://github.com/OuhscBbmc/REDCapR). {Added by Will, 2015-10.}
1. Following the existing [Troubleshooting Guide](https://cran.r-project.org/web/packages/REDCapR/vignettes/TroubleshootingApiCalls.html). {Added by Will, 2015-10.}
1. Store tokens on an [LDAP-managed database](https://cran.r-project.org/web/packages/REDCapR/vignettes/SecurityDatabase.html). {Added by Will, 2015-10.}
1. Use the [following patterns](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/tree/master/documentation_patterns). {Added by Will, 2015-10.}

### Validation
{I'm going to let our validation mechanism mature more before writing about it.}

# FAQ

1. **How does REDCap store data values?**

    There aren't individual/isolated tables per project.  REDCap's data table is a huge [EAV](https://en.wikipedia.org/wiki/Entity%E2%80%93attribute%E2%80%93value_model)) table where all the projects are stacked on top of each other.  Very similar to how EMRs store obs/observations for all clinics/forms/patients in a single table.  Super-duper normalized table.

     That's why non-superusers (without any [DDL](https://www.geeksforgeeks.org/sql-ddl-dml-dcl-tcl-commands/) permissions) can create their own projects.  The structure of the data table doesn't change when they add "columns", because variables are stored as additional rows in the underlying REDCap table.  REDCap's PHP pivots/widens the EAV table right before displaying the values to the user in a browser; the PHP unpivots/lengthens  the modified data before storing it back in the EAV table.
     
     The data table has a `project_id` column, which allows REDCap to enforce which users can read/modify which values.  {Added 2019-07)
