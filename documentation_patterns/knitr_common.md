Features of All Our Patterns that use [knitr](http://yihui.name/knitr/)
================
This document describes how we use knitr to create most reports.  It applies to both Rmd and Rnw files, and is appropriate for exploratory or inferential purposes.

## Summary
 * An Rmd or Rnw file is interpreted by `knitr` to eventually produce a report in an HTML or PDF format.
 * Each report is self-contained, in the sense that there are no loose image files or other resources associated with the report.  For instance, you can email the HTML/PDF file to colleauges, and not worry about relative paths pointing to image files.
 * The "code behind" file can be viewed as a companion to the report file(s).  We like to save the code behind file and the report file(s) in the same directory. 
 * The Rmd/Rnw file is organized into 'chunks'.  Most chunks call the associated code in the report's [code behind](./DocumentationPatterns/CodeBehind.md) file
 * A single code behind file can support multiple reports.  For example, you may want to show models results to two different audiences (say a group of colleauges and a group of politicians).  One report could show all the complex details (which technical language), and a second report could show just an abbreviation of it (with easily accessible language).
 * A single code behind file can be called by multiple reports.  For instance, an Rmd (*ie, Markdown-based knitr file that can be rendered as HTML*) can hook into the code behind file for a quick & dirty internal report that's intended just for your research team, while an Rnw (*ie, a LaTeX-based knitr file that can be rendered as a PDF*) can hook into the same code behind file for a polished external report that's intended for a wider audience. {TODO: merge this bullet with the previous one.}
 * To promote reproducibility, the document closes with information about the environment at the time of rendering.  This includes
    1. Who ran the report.
    2. The date and time (and possibly time zone).
    3. The package versions used, and other information returned by R's `sessionInfo()`.
 
## Connecting the Rmd file to the appropriate [code behind](./DocumentationPatterns/CodeBehind.md) file
Most of our report files are composed of these five stages.  This syntax is specific to Rmd files, but the concepts apply to Rnw files as well.

### 1. Set the working directory to the repository's base directory.
This assumes the report is nested inside of two directories.  Here's an example from the [Cars](./Analyses/Cars/Cars.Rmd) report.  (*However in the actual code, use triple backticks instead of triple quotes.  I needed to use single quotes here so the formate would be rendered correctly.*)

```
'''{r, echo=F, message=F} 
  # cat("Working directory: ", getwd()) #Uncomment to help diagnose.
  # Don't combine this call with any other chunk -especially one that uses file paths.
  knitr::opts_knit$set(root.dir='../../')  
'''
```

### 2. Set the report-wide options, and point to the external code file with `read_chunk()`.

```
'''{r set_options, echo=F}
require(knitr)

#To help knitr parse these arguments correctly, put comments at the end of call, not after each line. 
opts_chunk$set(
  results='show', 
  comment = NA, 
  tidy = FALSE,
  fig.width = 6.5, 
  fig.height = 4, 
  fig.path = 'FigureRaw/'
)
# dpi = 400,
# out.width = "650px", #This affects only the markdown, not the underlying png file.  The height will be scaled appropriately.

echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Analyses/Cars/Cars.R") #This allows knitr to call chunks tagged in the underlying *.R file.
'''
```

### 3. Prepare the environment for anlyses by first
   * Loading packages into memory
   * 'Source' other R files, which loads their function definitions into memory.  This is especially helpful when a handful of analyses/reports need the same function.  You don't want to retype it in every code behind file, but it's not used enough to justify the extra development overhead to include in a package.
   * Declaring necessary globally-scoped variables or functions used in the code behind file.
   * Declaring necessary globally-scoped variables or functions used specifically in the Rmd/Rnw file (these should be rare).
   * Load the dataset(s) in memory.  Usally they come from a database, a CSV, or an RDS (which is a compressed & binary format native to R).
   * Tweak the dataset(s).  Typically we only do light manipulation straight-forward joins; if the manipulation exceedes ~20 lines consider moving that operatoin into a new file.   

```

<!-- Load any source files containing functions. --> 
'''{r LoadSources, echo=echoChunks, message=FALSE}
'''

<!-- Load the packages.  Suppress the output when loading packages. --> 
'''{r LoadPackages, echo=echoChunks, message=FALSE}
'''

<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 
'''{r DeclareGlobals, echo=echoChunks, results='show', message=FALSE}
'''

<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 
'''{r, echo=echoChunks, message=FALSE}
'''

<!-- Load the datasets.   -->
'''{r LoadData, echo=echoChunks, results='show', message=FALSE}
'''

<!-- Tweak the datasets.   -->
'''{r TweakData, echo=echoChunks, results='show', message=FALSE}
'''
```

### 4. Call the chunks that run the analyses.  Notice that there's not analysis code in the Rmd file, only references to the chunks in the code behind file (which contains the analysis code).
```
# Marginals
'''{r Marginals, echo=echoChunks, message=TRUE}
'''

# Scatterplots
'''{r Scatterplots, echo=echoChunks, message=TRUE}
'''

# Models
'''{r Models, echo=echoChunks, message=TRUE}
'''
```

### 5. To facilitate reporducible research, close the document with environmental information.

```
# Session Information
For the sake of documentation and reproducibility, the current report was build on a system using the following software.

'''{r session_info, echo=FALSE}
cat("Report created by", Sys.info()["user"], "at", strftime(Sys.time(), "%Y-%m-%d, %H:%M %z"))
sessionInfo()
'''
```

## Notes
 * We typically ask knitr to perform several stages as it converts the Rmd file to an HTML file.
     1. knitr executes the R code contained in chunks.  The chunks can be in the Rmd file itself, or in the [code behind](./DocumentationPatterns/CodeBehind.md) file.
     2. The R output is mixed with the static content, to produce a Markdown file (with an *.md extention), as well as loose resources, such as image files.
     3. knitr then calls `pandoc` to convert the Mardown file to an HTML file.

 
## Examples
* [Cars](./Analyses/Cars/Cars.Rmd)

## See Also
* [Code Behind Pattern](./DocumentationPatterns/CodeBehind.md)
* [Inferential Markdown Report Pattern](./DocumentationPatterns/MarkdownReportInferential.md)
* [Polished LaTeX Report Pattern](./DocumentationPatterns/LatexReportPolished.md)
