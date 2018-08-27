rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------
#Load any source files that contain/define functions, but that don't load any other types of variables
#   into memory.  Avoid side effects and don't pollute the global environment.
source("./dal/clinical-trial-arch.R")

# ---- load-packages -----------------------------------------------------------
library(magrittr) #Pipes
library(ggplot2) #For graphing
requireNamespace("dplyr")
requireNamespace("tidyr") #For converting wide to long
# requireNamespace("RColorBrewer")
# requireNamespace("scales") #For formating values in graphs
# requireNamespace("mgcv) #For the Generalized Additive Model that smooths the longitudinal graphs.
# requireNamespace("TabularManifest") # devtools::install_github("Melinae/TabularManifest")

# The 'kableExtra' package makes great  LaTeX and HTML tables
#   * http://haozhu233.github.io/kableExtra/
#   * https://github.com/haozhu233/kableExtra
requireNamespace("kableExtra") # devtools::install_github("haozhu233/kableExtra")


# ---- declare-globals ---------------------------------------------------------
kabel_format  <- "html"

# ---- load-data ---------------------------------------------------------------
ds <- retrieve_clinical_trial()

# ---- tweak-data --------------------------------------------------------------


# ---- table-gender-ethnicity --------------------------------------------------
ds %>%
  dplyr::count(gender, ethnicity) %>%
  tidyr::spread(key=gender, value=n) %>%
  knitr::kable(
    caption = "Enthinicty and Gender Counts"
  ) %>%
  kableExtra::kable_styling(
    bootstrap_options = c("striped", "hover", "condensed", "responsive"),
    full_width        = FALSE
  )

# ---- table-gender-race -------------------------------------------------------
ds %>%
  dplyr::count(gender, race) %>%
  tidyr::spread(key=gender, value=n) %>%
  knitr::kable(
    caption = "Race and Gender Counts"
  ) %>%
  kableExtra::kable_styling(
    bootstrap_options = c("striped", "hover", "condensed", "responsive"),
    full_width        = FALSE
  )


# ---- marginals ---------------------------------------------------------------
TabularManifest::histogram_discrete(ds, "gender")
TabularManifest::histogram_discrete(ds, "ethnicity")
TabularManifest::histogram_discrete(ds, "race")

