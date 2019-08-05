
# Attach packages
library(caret)
library(cvms)
library(groupdata2)
# Set seed for reproducibility and easy comparison.
set.seed(3)
data(Sacramento)
full_data <- Sacramento
# Create one-hot encoded factor column describing 
# if the city is Sacramento or not
full_data$in_sacramento <- factor( 
  ifelse(full_data$city == "SACRAMENTO", 1, 0) )
# Log-transform predictors
full_data$log_sqft <- log(full_data$sqft)
full_data$log_beds <- log(full_data$beds)
full_data$log_baths <- log(full_data$baths)
# Partition the dataset
partitions <- partition(full_data, p = 0.8, 
                        cat_col = "in_sacramento")
train_set <- partitions[[1]]
valid_set <- partitions[[2]]
# Create folds
train_set <- fold(train_set, k = 5, 
                  cat_col = "in_sacramento")
# Create all combinations of the predictors 
model_formulas <- combine_predictors(
  dependent = "price", 
  fixed_effects = list("in_sacramento",
                       list("sqft", "log_sqft"),
                       list("baths", "log_baths"), 
                       list("beds", "log_beds")),
  max_effect_frequency = 1)

# Count the number of generated model formulas
length(model_formulas)
## [1] 255

# Show the last 10 formulas
tail(model_formulas, 10)
##  [1] "price ~ log_baths + log_beds * in_sacramento * log_sqft"
##  [2] "price ~ log_baths + log_beds * in_sacramento * sqft"    
##  [3] "price ~ log_baths + log_beds * in_sacramento + log_sqft"
##  [4] "price ~ log_baths + log_beds * in_sacramento + sqft"    
##  [5] "price ~ log_baths + log_beds * log_sqft + in_sacramento"
##  [6] "price ~ log_baths + log_beds * sqft + in_sacramento"    
##  [7] "price ~ log_baths + log_beds + in_sacramento * log_sqft"
##  [8] "price ~ log_baths + log_beds + in_sacramento * sqft"    
##  [9] "price ~ log_baths + log_beds + in_sacramento + log_sqft"
## [10] "price ~ log_baths + log_beds + in_sacramento + sqft"
# Cross-validate our models
cv_results <- cross_validate(data = train_set, 
                             models = model_formulas,
                             family = "gaussian")
# Order by RMSE
cv_results <- cv_results[order(cv_results$RMSE),]

# Create a subset with the 10 best models
cv_results_top10 <- head(cv_results, 10)
# Select the metrics and model formulas
# Print with knitr::kable for fanciness
kable(select_metrics(cv_results_top10), digits = 2)