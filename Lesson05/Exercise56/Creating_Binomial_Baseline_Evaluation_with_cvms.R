# Set seed for reproducibility and easy comparison
set.seed(1)

# Attach doParallel and
# register four CPU cores
library(doParallel)
registerDoParallel(4)

# Create baseline evaluations of the
# in_sacramento variable in the validation set
binomial_baselines <- baseline(
  test_data = valid_set,
  dependent_col = "in_sacramento",
  n = 100,
  family = "binomial",
  parallel = TRUE)

# Show the summarized results
binomial_baselines$summarized_metrics

