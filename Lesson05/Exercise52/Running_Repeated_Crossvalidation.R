
# Attach packages
library(cvms)
library(groupdata2)
# Set seed for reproducibility and easy comparison.
set.seed(2)
data(Sacramento)
full_data <- Sacramento
# Create one-hot encoded factor column describing 
# if the city is Sacramento or not
full_data$in_sacramento <- factor( 
  ifelse(full_data$city == "SACRAMENTO", 1, 0) )
partitions <- partition(full_data, p = 0.8, 
                        cat_col = "in_sacramento")
train_set <- partitions[[1]]
valid_set <- partitions[[2]]
# Create folds
train_set <- fold(train_set, k = 5, 
                  cat_col = "in_sacramento",
                  num_fold_cols = 10)
# Create the 10 fold column names
fold_cols <- paste0(".folds_", 1:10)

# Print the names
fold_cols
##  [1] ".folds_1"  ".folds_2"  ".folds_3"  ".folds_4"  ".folds_5" 
##  [6] ".folds_6"  ".folds_7"  ".folds_8"  ".folds_9"  ".folds_10"
# Order cv_results by RMSE
cv_results <- cv_results[order(cv_results$RMSE),]

# Reconstruct formulas for the top 8 models
model_formulas <- reconstruct_formulas(cv_results, topn = 8)

# Print the model formulas
model_formulas
## [1] "price ~ baths * in_sacramento + beds * sqft"                       
## [2] "price ~ beds * in_sacramento + beds * sqft"                        
## [3] "price ~ baths * beds + baths * in_sacramento + sqft"               
## [4] "price ~ baths * beds + baths * in_sacramento + beds * sqft"        
## [5] "price ~ beds * sqft + in_sacramento * sqft"                        
## [6] "price ~ baths * in_sacramento + beds * sqft + in_sacramento * sqft"
## [7] "price ~ baths + beds * in_sacramento + beds * sqft"                
## [8] "price ~ baths * in_sacramento + beds * in_sacramento + beds * sqft"
# Cross-validate our models
# Pass the list of fold column names 
# and cross_validate() will 
# cross-validate each one and 
# return the average results
repeated_cv_results <- cross_validate(
  data = train_set, 
  models = model_formulas,
  fold_cols = fold_cols, 
  family = "gaussian")
# Select the metrics and model formulas
# Print with knitr::kable for fanciness
kable(select_metrics(repeated_cv_results), digits = 2) 
# Extract the fold results for the best model
fold_results_best_model <- repeated_cv_results$Results[[1]]

# Print the results of the first 10 folds
kable( head(fold_results_best_model, 10) )