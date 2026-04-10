# plots.R
# Calibration plot for the 30-day readmission model.
# Outputs: outputs/calibration_plot.png

library(tidyverse)
library(CalibrationCurves)

dir.create("outputs", showWarnings = FALSE)

preds <- read_csv("outputs/model_predictions.csv")

# valProbggplot() draws a smooth calibration curve with 95% CI and annotated
# statistics (C-statistic, Brier score, calibration slope)
p <- valProbggplot(
  p = preds$predicted_prob,
  y = preds$readmitted_30d,
)$ggPlot

ggsave(
  "outputs/calibration_plot.png",
  plot = p,
  width = 6,
  height = 6,
  dpi = 150
)

message("Saved: outputs/calibration_plot.png")
