# model.R
# Fit a logistic regression model predicting 30-day readmission.
# Outputs: outputs/model_predictions.csv

library(tidyverse)
library(pROC)

# Create outputs directory if it doesn't exist
dir.create("outputs", showWarnings = FALSE)

# Load data
dat <- readRDS("data/admissions.rds")

# Fit logistic regression
fit <- glm(
  readmitted_30d ~ age +
    sex +
    diagnosis_group +
    prior_admissions +
    length_of_stay_days +
    discharge_type,
  data = dat,
  family = binomial(),
)
summary(fit)

# Save predicted probabilities
predictions <- dat |>
  mutate(predicted_prob = predict(fit, type = "response"))

write_csv(predictions, "outputs/model_predictions.csv")

# Performance metrics
auc_val <- auc(roc(
  predictions$readmitted_30d,
  predictions$predicted_prob,
  quiet = TRUE
))

brier <- mean((predictions$predicted_prob - predictions$readmitted_30d)^2)

cat("AUC:        ", round(auc_val, 3), "\n")
cat("Brier score:", round(brier, 4), "\n")
