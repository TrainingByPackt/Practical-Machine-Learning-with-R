# Attach packages
library(cvms)
library(groupdata2)
set.seed(1)
# Create all combinations of the predictors 
model_formulas <- combine_predictors(
  dependent = "price", 
  fixed_effects = c("in_sacramento",
                    "sqft", 
                    "baths", 
                    "beds"))
# Print the generated model formulas
head(model_formulas, 15)

# Create folds
train_set <- fold(
  train_set, k = 5, 
  cat_col = "in_sacramento",
  handle_existing_fold_cols = "remove")
# Cross-validate our models
# Note that we specify the model family as "gaussian", 
# which refers to linear regression
cv_results <- cross_validate(data = train_set, 
                             models = model_formulas,
                             fold_cols = ".folds", 
                             family = "gaussian")
# Order by RMSE
cv_results <- cv_results[order(cv_results$RMSE),]
# Select the 10 best models 
# (feel free to view them all instead)
cv_results_top10 <- head(cv_results, 10)
# Select the metrics and 
# model formulas with select_metrics()
# Print the top 10 models with 
# knitr::kable for fanciness
kable(select_metrics(cv_results_top10), digits = 2)
lin_model_7 <- lm("price ~ baths * in_sacramento + beds * sqft", 
data = train_set)
summary(lin_model_7)
                     
