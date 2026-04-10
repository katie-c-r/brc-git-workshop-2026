# clean.R
# Import and clean the raw admissions dataset.
# Outputs: data/admissions.rds

library(tidyverse)
library(janitor)

# Load and standardise column names
dat <- read_csv("data/admissions.csv") |>
  clean_names()

# Fix inconsistent coding, parse dates, convert types, drop incomplete rows
dat <- dat |>
  mutate(
    admission_date = dmy(admission_date),
    sex = case_when(
      sex %in% c("Male", "M") ~ "M",
      sex %in% c("Female", "F") ~ "F",
      .default = NA
    ),
    sex = factor(sex, levels = c("F", "M")),
    diagnosis_group = factor(diagnosis_group),
    discharge_type = factor(discharge_type),
    readmitted_30d = as.integer(readmitted_30d),
  ) |>
  drop_na(prior_admissions, discharge_type)

saveRDS(dat, "data/admissions.rds")
message(nrow(dat), " rows saved to data/admissions.rds")
