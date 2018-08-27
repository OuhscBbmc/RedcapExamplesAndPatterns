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

library(tidyverse)
library(janitor)
library(flextable)
library(magrittr)
library(writexl)
library(here)
library(officer)

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
ds <- retrieve_clinical_trial()

# ---- tweak-data --------------------------------------------------------------
# Slight modification of the dataset to correspond with @higgi13425's tables.

ibd <- ds %>%
  dplyr::rename(
    sex2        = gender
  ) %>%
  dplyr::mutate(
    ethnic_cat  = as.character(ethnicity),
    race        = as.character(race)
  )

# ---- table-ds ---------------------------------------------------------------
ds %>%
  dplyr::count(gender, ethnicity) %>%
  tidyr::spread(key=gender, value=n)

ds %>%
  dplyr::count(gender, race) %>%
  tidyr::spread(key=gender, value=n)

# create table of counts ----------------------------------------------

#first look at tabyl
ibd %>%
  tabyl(race, sex2)

ibd_table <- ibd %>%
  tabyl(race, sex2, ethnic_cat) %>%
  reduce(left_join, by = "race") %>%
  rename('Female.Unknown' = Female,
         'Male.Unknown' = Male,
         'Female.Not' = Female.y,
         'Male.Not' = Male.y,
         'Female.Hispanic' = Female.x,
         'Male.Hispanic' = Male.x)


# gather and filter to only non-zero categories ---------------------


ibd_table2 <- gather(ibd_table, key= sex.eth, value = count, -race) %>%
  separate(sex.eth, into = c('sex', 'ethnicity')) %>%
  filter(count != 0)
#results in 20 rows

#  create empty table -----------------------------------------------------

l <- list(race =
            c("White",
              "Black or African-American",
              "Asian",
              "Native Hawaiian or Other Pacific Islander",
              "American Indian or Alaska Native",
              "More Than One Race",
              "Unknown or Not Reported"),
          sex = c("Male",
                  "Female",
                  "Unknown or Not Reported Sex",
                  "Male",
                  "Female",
                  "Male",
                  "Female"),
          ethnicity = c("Hispanic",
                        "Not",
                        "Unknown",
                        "Hispanic",
                        "Not",
                        "Hispanic",
                        "Not"),
          count = rep(0,7))

empty_table <- as_tibble(l) %>%
  tidyr::complete(race,
                  nesting(sex), nesting(ethnicity),fill=list(count = 0))

# anti-join ibd_table2 ----------------------------------------------------
# now anti-join ibd_table2 with empty_table to get missing rows
# with no counts in our sample
complement <- anti_join(empty_table, ibd_table2, by = c('race', 'sex', "ethnicity")) %>%
  print(n=Inf)


# now combine complement with ibd_table2
full_table <- bind_rows(ibd_table2, complement)


# wrangle nested sex within ethnicity -------------------------------------


# take full table, unite, then spread
# will need to nest sex within ethnicity
# three cols - race, eth.sex, count
# then spread to 11 cols
ibd_table <- full_table %>%
  unite(col = "eth.sex", c('ethnicity', "sex"), sep=".") %>% # three cols - race, eth.sex, count
  spread(key = eth.sex, value = count)  # now spread to 10 cols


# add margin totals -------------------------------------------------------

# convert race col to rownames to make numbers into a matrix
m <- as.matrix(ibd_table[ ,-1])
rownames(m) <- ibd_table$race
ibd_table2 <- addmargins(m, FUN=c(Total=sum), quiet = T)
ibd_table <- rownames_to_column(as.data.frame(ibd_table2), "Racial Categories")
# now 11 cols with total

#arrange without total
ibd_table3 <- ibd_table[1:7,] %>% arrange(`Racial Categories`)
# add back total
ibd_table <- as.data.frame(rbind(ibd_table3, ibd_table[8,]))

# and write to excel
write_xlsx(ibd_table, here("ibd_table.xlsx"))


# make flextable ----------------------------------------------------------

myft <- ibd_table %>%
  regulartable() %>%
  theme_booktabs() %>%
  set_formatter_type(fmt_double = "%0.0f") %>%
  add_header(`Racial Categories` = "Racial Categories",
             Hispanic.Female = "Hispanic or Latino",
             Hispanic.Male = "Hispanic or Latino",
             `Hispanic.Unknown or Not Reported Sex` = "Hispanic or Latino",
             Not.Female = "Not Hispanic or Latino",
             Not.Male = "Not Hispanic or Latino",
             `Not.Unknown or Not Reported Sex` = "Not Hispanic or Latino",
             Unknown.Female = "Unknown/Not Reported",
             Unknown.Male = "Unknown/Not Reported",
             `Unknown.Unknown or Not Reported Sex` = "Unknown/Not Reported",
             Total = "Total") %>%
  add_header(`Racial Categories` = "Racial Categories",
             Hispanic.Female = "Ethnic Categories Divided by Sex",
             Hispanic.Male = "Ethnic Categories Divided by Sex",
             `Hispanic.Unknown or Not Reported Sex` = "Ethnic Categories Divided by Sex",
             Not.Female = "Ethnic Categories Divided by Sex",
             Not.Male = "Ethnic Categories Divided by Sex",
             `Not.Unknown or Not Reported Sex` = "Ethnic Categories Divided by Sex",
             Unknown.Female = "Ethnic Categories Divided by Sex",
             Unknown.Male = "Ethnic Categories Divided by Sex",
             `Unknown.Unknown or Not Reported Sex` = "Ethnic Categories Divided by Sex",
             Total = "Total") %>%
  set_header_labels(`Racial Categories` = "Racial Categories",
                    Hispanic.Female = "Female",
                    Hispanic.Male = "Male",
                    `Hispanic.Unknown or Not Reported Sex` = "Unknown",
                    Not.Female = "Female",
                    Not.Male = "Male",
                    `Not.Unknown or Not Reported Sex` = "Unknown",
                    Unknown.Female = "Female",
                    Unknown.Male = "Male",
                    `Unknown.Unknown or Not Reported Sex` = "Unknown",
                    Total = "Total") %>%
  font(fontname = "Arial") %>%
  fontsize(size = 10) %>%
  fontsize(size=12, part="header") %>%
  merge_h(part= "header") %>%
  merge_v(part= "header") %>%
  align(align = "center", part = "all") %>%
  width(j = 1, width = 2.0)

myft


# save as word document with officer ---------------------------------------------------

doc <- read_docx()
doc <- body_add_flextable(doc, value = myft)
print(doc, target = "/Users/peterhiggins/Documents/Rcode/nih_enrollment_table/word_table.docx")


# save as ppt slide with officer -------------------------------------------------------

ppt <- read_pptx()
ppt <- add_slide(ppt, layout = "Title and Content",
                 master = "Office Theme")
ppt <- ph_with_flextable(ppt, value = myft, type= "body")
print(ppt, target = "/Users/peterhiggins/Documents/Rcode/nih_enrollment_table/ppt_slide.pptx")

sessionInfo()
