Features of All Our Patterns that use `knitr` 
================
This document describes how we always use knitr files, regardless if they're an Rmd or and Rnw, or if the report is for exploratory or inferential purposes.

## Summary
 * An Rmd or Rnw file is interpreted by `knitr` to eventually produce a report in an HTML or PDF format.
 * Each report is self-contained, in the sense that there are no loose image files or other resources associated with the report.  For instance, you can email the HTML/PDF file to colleauges, and not worry about relative paths pointing to image files.
 * The code behind file can be viewed as a companion to the report file(s).  We like to save the code behind file and the report file(s) in the same directory.
 * The Rmd/Rnw file is organized into 'chunks'.  Most chunks call the associated code in the report's [code behind](./DocumentationPatterns/CodeBehind.md) file
 * A single code behind file can be called by multiple reports.  For instance, an Rmd (*ie, Markdown-based knitr file that can be rendered as HTML*) can hook into the code behind file for a quick & dirty internal report that's intended just for your research team, while an Rnw (*ie, a LaTeX-based knitr file that can be rendered as a PDF*) can hook into the same code behind file for a polished external report that's intended for a wider audience.
 * To promote reproducibility, the document closes with information about the environment at the time of rendering.  This includes
    1. Who ran the report.
    2. The date and time (and possibly time zone).
    3. The package versions used, and other information returned by R's `sessionInfo()`.
 
## Connecting the Rmd file to the appropriate [code behind](./DocumentationPatterns/CodeBehind.md) file


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

 
## Examples
* [Cars](./Analyses/Cars/Cars.R)

## See Also
* [Code Behind Pattern](./DocumentationPatterns/CodeBehind.md)
* [Inferential Markdown Report Pattern](./DocumentationPatterns/MarkdownReportInferential.md)
* [Polished LaTeX Report Pattern](./DocumentationPatterns/LatexReportPolished.md)
