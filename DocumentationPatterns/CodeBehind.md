Code Behind Pattern
================

## Summary

 * It is an R file that can specify tables, graphs, or statistical models.
 * The code behind file can be viewed as a companion to the report file(s).  We like to save the code behind file and the report file(s) in the same directory.
 * It's the last file in the workflow before a `knitr` report file (typically an Rnw or Rmd).
 * Each logical section of code is separated into a 'chunk' and labelled so that the knitr code can hook into the right spots.
 * A single code behind file can be called by multiple reports.  For instance, an Rmd (*ie, Markdown-based knitr file that can be rendered as HTML*) can hook into the code behind file for a quick & dirty internal report that's intended just for your research team, while an Rnw (*ie, a LaTeX-based knitr file that can be rendered as a PDF*) can hook into the same code behind file for a polished external report that's intended for a wider audience.

## Notes
 * The file should be able to run independently of the report file.  There are two advantages:
    * The lack of dependency makes the file's relationships conceptually cleaner.
    * Since the file can execute by itself, it's easier to develop and debug.  The file can be run in it's entirety (Ctrl+Alt+R in RStudio), or several lines at a time (highlight the desired lines and Ctrl+Return in RStudio).
 * Altough a report can execute the code behind's chunks in any order, we recommend running them in the same order as they appear in the code behind, because:
    * It's easier understand and spot mistakes (such as inadvertantly skipping a section, or confusing the order of several sections). 
    *  You can execute the code-behind file in its entirety (eg, Ctrl+Alt+R). This closely mimics how the report will execute, which makes development easier.
 
## Examples
* [Cars](./Analyses/Cars/Cars.R)

## See Also
* [Exploratory Markdown Report Pattern](./DocumentationPatterns/MarkdownReportExploratory.md)
* [Inferential Markdown Report Pattern](./DocumentationPatterns/MarkdownReportInferential.md)
* [Polished LaTeX Report Pattern](./DocumentationPatterns/LatexReportPolished.md)
