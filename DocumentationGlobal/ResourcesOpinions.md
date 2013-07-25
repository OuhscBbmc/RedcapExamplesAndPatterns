# Additional Resources for our Software Recommendations
This document is a collection of unoffical articles & blogs that I've found helpful establishing our reporting system of R, RStudio, knitr, Markdown, and GitHub
 
### Reproducible Research
According to the [R Task View](http://cran.r-project.org/web/views/ReproducibleResearch.html), "The goal of reproducible research is to tie specific instructions to data analysis and experimental data so that scholarship can be recreated, better understood and verified."  Reproducible research is strongly behind the philosophy of this reporting project, for three reasons. 

1. The enforced consistency suggested should reduce bugs that were created my manual, ad-hoc, manipulation.  
1. People inside and outside of the research team can read & run the syntax behind the reports & analyses, and therefore understand and validate that it meets their understandings.  This capability is likely to become more important in the future with externally funded projects.  It's intended to reduce any suspicions of the team's ethics and competence.
1. Automated reports are much quicker to produce and replace outdated reports.  Fresher information should produce better monitoring and decision-making.

We won't be entirely reproducible (in the sense that an outsider could use our tools and data to arrive at the exact same analyses), because of the PHI.  We'll need to discuss about which aspects and data make sense to expose, and what doesn't. As Gentlemen and Lang write (2004, p. 12):  
>It is also important to consider some limitations associated with data capture in the process of creating a compendium. While ideally we would like to capture the data at as early a stage as possible, it is not feasible to do so in a entirely reproducible way (except for simulation experiments). For example, transformations to anonymize the data for privacy reasons may introduce errors but we cannot verify these. Thus, in the context of real data, some decision will need to be made about the point at which the data are captured in the compendium. 

If you have a feel for reproducible research by now, your time is probably better spent learning the tools required to do it.  But here's a collection of documents that I've liked on the subject.  *Literate Programming* is seen as an essential part of reproducible research, so all those articles apply here too.
* **Statistical Analyses and Reproducible Research**, article in 2004 by Robert Gentlemen (a founder of R) and Temple Lang.  http://biostats.bepress.com/cgi/viewcontent.cgi?article=1001&context=bioconductor {added Oct 2012}
* **Reproducible Research** website of the semi-official movement.  http://reproducibleresearch.net/index.php/Main_Page and http://www.reproducibleresearch.net/blog/ {added Oct 2012}

### Overall Workflow
* [Choosing Your Workflow Applications](http://www.kieranhealy.org/files/misc/workflow-apps.pdf) {added Oct 5, 2012}
* [R and version control for the solo data analyst](http://stackoverflow.com/questions/2712421/r-and-version-control-for-the-solo-data-analyst) {added Oct 5, 2012}
* [How do you combine “Revision Control” with “Workflow” for R?](http://stackoverflow.com/questions/2286831/how-do-you-combine-revision-control-with-workflow-for-r) {added Oct 5, 2012}

### GitHub and git
GitHub and git have been described in our previous 'Resources' pages.  Here are some opinions and blogs that might help put things in perspective more.
* [Git Magic](http://www-cs-students.stanford.edu/~blynn/gitmagic/) Click on the TOC on the left {added Oct 5, 2012}
* We have the [Git book](http://www.amazon.com/Version-Control-Git-collaborative-development/dp/1449316387/ref=dp_ob_title_bk) published by O'Reilly.  The last chapter on GitHub is perfect for most of the developers on this project. {added Oct 2012}

### Reporting & Literate Programming
* [Integrate data and reporting on the Web with knitr](http://blog.revolutionanalytics.com/2012/09/data-reporting-knitr.html) From the knitr developer {added Oct 14, 2012}
* [New Tools for Reproducible Research with R](http://yihui.name/slides/2012-knitr-RStudio.html) Slide show that David likes; from the RStudio founder and the knitr developer {added Nov 18, 2012}
* [Dynamic Documents with R and knitr](http://www.crcpress.com/product/isbn/9781482203530) is written by the knitr developer, Yihui Xie.  It hasn't been released yet, but I'm fairly confident it will be worth reading. {added July 2013}
* [Reproducible Research with R and RStudio](http://www.crcpress.com/product/isbn/9781466572843) is another upcoming book that should be good for people reading this document.  I haven't read anything by the author, Christopher Gandrud, but the two pre-release chapters are relevant to these types of projects, particularly Figure 2.1.  The book has an accompanying [website](http://christophergandrud.github.io/RepResR-RStudio/) that links to [chapter examples](https://github.com/christophergandrud/Rep-Res-Examples) and an [example project](https://github.com/christophergandrud/Rep-Res-ExampleProject1) on GitHub. {added July 2013}

### R Programming
* Phil Spector's book [Data Manipulation with R](http://books.google.com/books/about/Data_Manipulation_with_R.html?id=grfuq1twFe4C) is very valuable for our project's tasks that occur before the data gets to the report layer.  It is downloadable from our library.  Also, if you order it through our library's SpringerLink, it costs just $25 -as with all books in the [UseR! series](http://www.springer.com/series/6991), and many other Springer books. {added Oct 2012}
* When working with dates: read the (1) 'Dates' chapter in Spector's book, [Data Manipulation with R](http://books.google.com/books/about/Data_Manipulation_with_R.html?id=grfuq1twFe4C), (2) `lubridate` package [manual](http://cran.r-project.org/web/packages/lubridate/), and (3)  `lubridate`  [JSS article](http://www.jstatsoft.org/v40/i03/paper). {added Oct 2012}
* When working with factors: read the (1) 'Factors' chapter in Spector's book, [Data Manipulation with R](http://books.google.com/books/about/Data_Manipulation_with_R.html?id=grfuq1twFe4C)  {added Oct 2012}
* Hadley Wickham's [`reshape2`](http://cran.r-project.org/web/packages/reshape2/index.html) package is helpful when transforming dataset between wide and long formats.  This especially applies to our project, because REDCap exposes the data in an ultra-wide format (ie, one record per subject), and stores the data in MySQL as an ultra-long format (ie, one record per *value*).  The package has a [website](http://had.co.nz/reshape/) and a [JSS article](http://www.jstatsoft.org/v21/i12/paper). {added Oct 2012}
* Wickham's [`plyr`](http://cran.r-project.org/web/packages/plyr/index.html) package is great for doing all kinds of manipulation outside the scope of `reshape2`.  It's especially good for summarizing cells/groups of subjects.  The package has a [website](http://plyr.had.co.nz/) and a  [JSS article](http://www.jstatsoft.org/v40/i01/paper).  My favorite material on `plyr` is the first few pages of Chapter 9 in the [ggplot2](http://books.google.com/books?id=F_hwtlzPXBcC) book.  Andrey's friend attended this talk and suggested this link: http://stat405.had.co.nz/utah/plyr.pdf.  If someone sees good example code for parallelizing `plyr` code, please tell me; I've had trouble with the examples working well in Windows {added Oct 2012}
* Wickham is also working on a book on R programming, with some of its contents on the [devtools GitHub wiki](https://github.com/hadley/devtools/wiki).  Consider responding to the examples in markdown, while saving the progressing work to GitHub repository dedicated to your exercises.  Play with different file and directory arrangements to see which style suits you best.  The best tradeoff is somewhere between one large md file for all the book's examples, and one md file for each item.
 
### Graphing
* Start with the documents mentioned in [ResourcesOfficial.md](https://github.com/OuhscBbmc/RedcapApiExample/blob/master/DocumentationGlobal/ResourcesOfficial.md#graphs).
* We recommend using the [`ggplot2`](http://ggplot2.org/) package when possible.  The goals is feasible, and was reached on projects where most of the developers were also newly exposed to R, knitr/Sweave, and GitHub.  The [Grammar of Graphics](http://books.google.com/books/about/The_Grammar_of_Graphics.html?id=_kRX4LoFfGQC) is fantastic for its productivity and aesthetics, but it is yet another layer/tool necessary to learn.  {updated July 2013}
* `ggplot2` syntax changed somewhat when version 0.9 was released Feb 2012, particularly with the themes, formats, and options.  The [0.9 transition guide](https://github.com/hadley/ggplot2/downloads) documents the changes well.  When looking at forums, pay attention to if it was before Feb 2012. {added Oct 2012}
* [R Graphics](http://books.google.com/books?id=fxL4tu5bzAAC) [Cookbook](http://shop.oreilly.com/product/0636920023135.do) is great, and quick to read. Winston works with Hadley at RStudio, and he has great posts on the [ggplot2 Google group](https://groups.google.com/forum/?fromgroups#!forum/ggplot2).  This book mostly uses ggplot2. Don't confuse this book with [R *Graphs* Cookbook](http://books.google.com/books/about/R_Graphs_Cookbook.html?id=oKY5QeSWb4cC), which has a very similar name, but is entirely about base graphics.  Also, don't confuse it with the book, [R Cookbook](http://books.google.com/books/about/R_Cookbook.html?id=KIHuSXyhawEC), which was written by someone else, but has a very similar cover. {Added April 2013}
* [Cookbook for R](http://www.cookbook-r.com/) is a website by Winston Chang (who wrote  [R *Graphics* Cookbook](http://books.google.com/books/about/R_Graphs_Cookbook.html?id=oKY5QeSWb4cC)). {Added April 2013}
* The [ggplot2 Google group](https://groups.google.com/forum/?fromgroups#!forum/ggplot2) is the official forums for the package.  [StackOverflow](http://stackoverflow.com/questions/tagged/ggplot2) is another good place. {Added Feb 213}
* If you like video, here's an [hour long tour](http://www.revolutionanalytics.com/news-events/free-webinars/2012/ggplot2-with-hadley-wickham/) of `ggplot2` by Hadley. {added Jan 2013}
* Leland Wilkinson's book, [The Grammar of Graphics](http://books.google.com/books/about/The_Grammar_of_Graphics.html?id=_kRX4LoFfGQC), is the basis of *gg* plot2.  It's not necessary to read for this project's reports.  But it's a cool book if you make the time. Our library has the chapter PDFs for free. {added Oct 2012}
* Paul Murrell's book, [R Graphics](http://books.google.com/books?id=uacCQgAACAAJ&dq), is another one of my favorites, especially if you get outside `ggplot2`. The second edition has only one chapter on `ggplot2` (the first edition entirely predates `ggplot2`).  It's still a good reference if you need to combine multiple ggplots.  If you're developing graphs outside of `ggplot2`, it's my top recommendation. It has [downloadable code](http://www.stat.auckland.ac.nz/~paul/RGraphics/rgraphics.html) for all the book's graphs. {added Oct 2012}

### Color
Learning a little about color will help you create better graphs. My two favorite approaches are [HCL](http://tristen.ca/hcl-picker) and [ColorBrewer](http://colorbrewer2.org/).  Fortunately ggplot2 supports both of them easily.  If you're familar with the ideas behind them, you can develop graphs quicker too, instead of relying on trial-and-error to get it correct.  Both approaches were developed independent of R, but have packages and lots of documentation about them. {added Feb 2012}
 * [HCL](http://tristen.ca/hcl-picker) represents color with the three components/dimensions of hue, chroma lightness.  It is implemented in the [colorspace](http://cran.r-project.org/web/packages/colorspace/) package. It has a good [vignette](http://cran.r-project.org/web/packages/colorspace/vignettes/hcl-colors.pdf) and [article](http://www.sciencedirect.com/science/article/pii/S0167947308005549).  A theoretical [article](http://mmir.doc.ic.ac.uk/mmir2005/CameraReadyMissaoui.pdf) on HCL is by Sarifuddin and Missaoui. {added Feb 2012}
 * [ColorBrewer](http://colorbrewer2.org/) has a good site that has explanations/references and lets you pick specific palettes.  It has a finite set of schemes, and doesn't have the mathematical foundation that HCL has.  But the color schemes have been refined by perceptual experiments.  It is implemented in the [RColorBrewer](http://cran.r-project.org/web/packages/RColorBrewer/) package. I typically use it instead of HCL for categorical variables when it doesn't matter if some categories have slightly more intense colors than other categories.  I like the webpage best, because it (1) quickly gives you an example map, (2) allows you to specify how many colors in the palette, and (3) gives the RGB values for each color.  Within R, a quick version of this can be seen by executing `RColorBrewer::display.brewer.all()`. {added Feb 2012}
 * [vis4.net](http://vis4.net/blog/posts/avoid-equidistant-hsv-colors/) has a good quick blog post on  that adds some more context. {added Feb 2012}

### Coding Practice
* As the project's codebase grows larger with more and bigger files, it's important to maintain the code so that it is robust and clear.  It's not enough that the code works.  If the code is messy and hard to understand, other pieces the interact with it are affected.  Please read this post on [technical debt](http://www.codinghorror.com/blog/2009/02/paying-down-your-technical-debt.html).  The whole [Coding Horror](http://www.codinghorror.com/blog/) blog is good, and most of it could be relevant to your coding. {added Jan 2013}
* My favorite language agnostic book is [Code Complete 2](http://www.amazon.com/Code-Complete-Practical-Handbook-Construction/dp/0735619670/ref=la_B000APETRK_1_1?ie=UTF8&qid=1357228770&sr=1-1) by Steve McConnell.  I know it's hard to make time to read something that doesn't directly influence a specific task you're working on.  But this book is really good and will improve almost every aspect of your programming.  If you have time for only one chapter, ask me and I'll see if I can help find one that will be most influential for your current task/stage. {added Jan 2013}