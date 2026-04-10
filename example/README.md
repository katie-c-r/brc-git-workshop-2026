# Readmission prediction — running example

Toy clinical prediction model used as the running example in the
*Git for people who've been meaning to learn Git* workshop (NIHR Maudsley BRC, April 2026).

## Data

`data/admissions.csv` — 500 synthetic inpatient records.
Variables: patient ID, admission date, age, sex, diagnosis group, prior admissions,
length of stay, discharge type, medication prescribed, 30-day readmission (outcome).

**The `data/` folder is excluded from version control (see `.gitignore`).**

## Scripts

Run in order:

| Script | What it does |
|---|---|
| `scripts/clean.R` | Imports raw data, fixes column names, parses dates, handles missing values |
| `scripts/model.R` | Fits a logistic regression model; saves predicted probabilities and performance metrics (AUC, Brier score, calibration slope and intercept) |
| `scripts/plots.R` | Produces a smooth calibration plot (`outputs/calibration_plot.png`) |

## Requirements

```r
install.packages(c("tidyverse", "janitor", "pROC", "CalibrationCurves"))
```
