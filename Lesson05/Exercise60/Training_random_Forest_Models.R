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
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  0  1
##          0 64 28
##          1 35 60
##                                           
##                Accuracy : 0.6631          
##                  95% CI : (0.5905, 0.7304)
##     No Information Rate : 0.5294          
##     P-Value [Acc > NIR] : 0.0001434       
##                                           
##                   Kappa : 0.3268          
##                                           
##  Mcnemar's Test P-Value : 0.4496918       
##                                           
##               Precision : 0.6316          
##                  Recall : 0.6818          
##                      F1 : 0.6557          
##              Prevalence : 0.4706          
##          Detection Rate : 0.3209          
##    Detection Prevalence : 0.5080          
##       Balanced Accuracy : 0.6641          
##                                           
##        'Positive' Class : 1               
## 