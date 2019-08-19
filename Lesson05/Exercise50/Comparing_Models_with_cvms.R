# Attach packages
library(cvms)
library(groupdata2)

# Set seed for reproducibility
set.seed(2)

# Create vector with model formulas
model_formulas <- c(
  "price ~ in_sacramento",
  "price ~ in_sacramento + sqft",
  "price ~ in_sacramento + sqft + beds",
  "price ~ in_sacramento + sqft + beds + baths",
  "price ~ in_sacramento + beds + baths")

# Create folds
train_set <- fold(train_set, k = 5,
                  cat_col = "in_sacramento")

# Cross-validate our models
# Note that we specify the model family as "gaussian",
# which refers to linear regression
cv_results <- cross_validate(data = train_set,
                             models = model_formulas,
                             fold_cols = ".folds",
                             family = "gaussian")

cv_results

# Attach knitr
library(knitr)

# Select the metrics and model formulas
# with select_metrics()
# Print with knitr::kable for fanciness,
# and round to 2 decimals.
kable(select_metrics(cv_results), digits = 2)

