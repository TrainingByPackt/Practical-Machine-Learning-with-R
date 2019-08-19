# Attach packages
library(caret)
library(cvms)
library(groupdata2)
library(knitr)

# Set seed for reproducibility and easy comparison.
set.seed(2)

# Load the dataset
data(Sacramento)

# Create one-hot encoded factor column describing if the city is
Sacramento or not
full_data$in_sacramento <- factor(
  ifelse(full_data$city == "SACRAMENTO", 1, 0) )

# Log-transform predictors
full_data$log_sqft <- log(full_data$sqft)
full_data$log_beds <- log(full_data$beds)
full_data$log_baths <- log(full_data$baths)
full_data$log_price <- log(full_data$price)

partitions <- partition(full_data, p = 0.8,
                        cat_col = "in_sacramento")
train_set <- partitions[[1]]
valid_set <- partitions[[2]]

logistic_model_1 <- glm(in_sacramento ~ price,
                        data = train_set,
                        family = "binomial")
summary(logistic_model_1)

logistic_model_2 <- glm(in_sacramento ~ price + baths,
                        data = train_set,
                        family = "binomial")
summary(logistic_model_2)

logistic_model_3 <- glm(in_sacramento ~ price + baths + sqft,
                        data = train_set,
                        family = "binomial")
summary(logistic_model_3)

# Create folds
train_set <- fold(train_set, k = 5,
                  cat_col = "in_sacramento")

# Create all combinations of the predictors
model_formulas <- combine_predictors(
  dependent = "in_sacramento",
  fixed_effects = list(list("price","log_price"),
                       list("sqft", "log_sqft"),
                       list("baths","log_baths"),
                       list("beds", "log_beds")),
  max_effect_frequency = 1)

# Count the number of generated model formulas
length(model_formulas)

# Show the last 10 formulas
tail(model_formulas, 10)

# Attach doParallel
library(doParallel)
# Register four CPU cores
registerDoParallel(4)

# Cross-validate our models in parallel
cv_results <- cross_validate(data = train_set,
                             models = model_formulas,
                             family = "binomial",
                             parallel = TRUE)

# Order by RMSE
cv_results <- cv_results[
  order(cv_results$F1, decreasing = TRUE),]
# Create a subset with the 10 best models
cv_results_top10 <- head(cv_results, 10)
cv_results_top10

# Select the metrics and model formulas
cv_results_top10 <- select_metrics(cv_results_top10)
# Remove some of the metrics
# Note: A great alternative is dplyr::select()
# In general, the dplyr package is amazing
cv_results_top10 <- cv_results_top10[,
                                     !(colnames(cv_results_top10) %in%
                                         c("Lower CI",
                                           "Upper CI","Detection Rate",
                                           "Detection Prevalence",
                                           "Prevalence")), drop=FALSE]
# Print with knitr::kable for fanciness
kable(cv_results_top10, digits = 3)

# Evaluate the best model on the validation set with validate()
V_results_list <- validate(
  train_data = train_set,
  test_data = valid_set,
  models = "in_sacramento ~ baths * log_price * log_sqft + log_beds",
  family = "binomial")
V_model <- V_results_list$Models[[1]]
V_results <- V_results_list$Results
# Select metrics
V_results <- select_metrics(V_results)
# Remove some of the metrics
V_results <- V_results[, !(colnames(V_results) %in% c(
  "Lower CI","Upper CI","Detection Rate",
  "Detection Prevalence", "Prevalence")), drop=FALSE]
# Print the results
kable(V_results, digits = 3)

# Print the model summary and interpret it
summary(V_model)


