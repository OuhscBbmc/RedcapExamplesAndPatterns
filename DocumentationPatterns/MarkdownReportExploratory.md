Exploratory Markdown Report Pattern
================

## Summary

 * It is an Rmd file that's interpreted by `knitr` to eventually produce an HTML report.
 
 there are no loose image files or other resources.  The HTML file is easily distributed by email
 * The code behind file can be viewed as a companion to the report file(s).  We like to save the code behind file and the report file(s) in the same directory.
 * It's the last file in the workflow before a `knitr` report file (typically an Rnw or Rmd).
 * Each logical section of code is separated into a 'chunk' and labelled so that the knitr code can hook into the right spots.
 * A single code behind file can be called by multiple reports.  For instance, an Rmd (*ie, Markdown-based knitr file that can be rendered as HTML*) can hook into the code behind file for a quick & dirty internal report that's intended just for your research team, while an Rnw (*ie, a LaTeX-based knitr file that can be rendered as a PDF*) can hook into the same code behind file for a polished external report that's intended for a wider audience.
 
## Connecting the Rmd file to the appropriate [code behind](./DocumentationPatterns/CodeBehind.md) file

This section describes how we always use knitr files, regardless if they're an Rmd or and Rnw.
1. Set the working directory to the repository's base directory; this assumes the report is nested inside of two directories.-->
```{r, echo=F, message=F} 
# cat("Working directory: ", getwd())

  knitr::opts_knit$set(root.dir='../../')  #Don't combine this call with any other chunk -especially one that uses file paths.
```

## Notes
 * We typically ask knitr to perform several stages as it converts the Rmd file to an HTML file.
     1. knitr executes the R code contained in chunks.  The chunks can be in the Rmd file itself, or in the [code behind](./DocumentationPatterns/CodeBehind.md) file.
     2. The R output is mixed with the static content, to produce a Markdown file (with an *.md extention), as well as loose resources, such as image files.
     3. knitr then calls `pandoc` to convert the Mardown file to an HTML file.
 * The HTML file is self-contained, in the sense that there are no loose image files or other resources.  For instance, you can email the HTML file to colleauges, and not worry about relative paths pointing to image files.
 
## Examples
* [Cars](./Analyses/Cars/Cars.R)

## See Also
* [Code Behind Pattern](./DocumentationPatterns/CodeBehind.md)
* [Inferential Markdown Report Pattern](./DocumentationPatterns/MarkdownReportInferential.md)
* [Polished LaTeX Report Pattern](./DocumentationPatterns/LatexReportPolished.md)
