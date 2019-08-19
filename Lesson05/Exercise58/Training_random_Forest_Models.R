# Attach packages
library(randomForest)
library(caret)
# Set seed for reproducibility and easy comparison.
set.seed(1)
rf_model_regression <- randomForest(
  formula = price ~ beds + baths + sqft + in_sacramento, 
  data = train_set)
# Predict prices in the validation set
price_predictions <- predict(rf_model_regression, valid_set)

# Calculate and print the RMSE
RMSE(price_predictions, valid_set$price)
## [1] 86957.24
rf_model_classification <- randomForest(
  formula = in_sacramento ~ beds + baths + sqft + price,
  data = train_set)
# Predict in_sacramento in the validation set
in_sacramento_predictions <- predict(rf_model_classification, 
                                     valid_set)

# Create a confusion matrix and print it
confusionMatrix(in_sacramento_predictions, 
                valid_set$in_sacramento, 
                positive = "1",
                mode = "prec_recall")
