# Designing Reports
## Internal vs External Reports
Most of our reports will be *internal*, meaning only handful of OUHSC researchers will ever see it.  Let's keep their cosmetics as spartan as possible.  Having fewer components should help them be (1) quicker to develop, (2) easier to replicate its structure and feel in sister reports, and (3) less trouble to maintain over the years.  Consider these factors when designing your report.

As the study progresses, they'll be a few *external* reports that funders, administrators, researchers and possibly politicians will see.  The audience for some of these reports may have a good head, but will lack a research & statistics background, and will be unfamilar with many graphical and analytical conventions.  In these cases, it's worth our time to make the analyses and graphs cleaner and more self-evident.

Let's try to write all our internal reports in Markdown (with knitr), and ultimately display them as HTML files.  Let's try to write all our external reports in LaTeX (with knitr), and ultimately display them as PDFs.  We'd like a good way to create the tables for our articles (which must be in a docx format for most journals); this likely will involve [pandoc](http://johnmacfarlane.net/pandoc/), and I'll write more about it as we figure it out.  We should also explore the best ways to use Shiny and RStudio Server to distribute interactive reports.

