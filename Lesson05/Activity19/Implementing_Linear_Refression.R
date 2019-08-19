
# Attach packages
library(groupdata2)
library(cvms)
library(caret)
library(knitr)
# Set seed for reproducibility and easy comparison
set.seed(1)
# Load the cars dataset
data(cars)
# Partition the dataset
partitions <- partition(cars, p = 0.8)
train_set <- partitions[[1]]
valid_set <- partitions[[2]]

# Fit a couple of linear models and interpret them
# Model 1 - Predicting price by mileage
model_1 <- lm(Price ~ Mileage, data = train_set)
summary(model_1)
## 
## Call:
## lm(formula = Price ~ Mileage, data = train_set)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -12977  -7400  -3453   6009  45540 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  2.496e+04  1.019e+03  24.488  < 2e-16 ***
## Mileage     -1.736e-01  4.765e-02  -3.644 0.000291 *** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9762 on 641 degrees of freedom
## Multiple R-squared:  0.02029,    Adjusted R-squared:  0.01876 
## F-statistic: 13.28 on 1 and 641 DF,  p-value: 0.0002906
# Model 2 - Predicting price by number of doors
model_2 <- lm(Price ~ Doors, data = train_set)
summary(model_2)
## 
## Call:
## lm(formula = Price ~ Doors, data = train_set)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -12540  -7179  -2934   5814  45805 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  25682.2     1662.1  15.452   <2e-16 ***
## Doors        -1176.6      457.5  -2.572   0.0103 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9812 on 641 degrees of freedom
## Multiple R-squared:  0.01021,    Adjusted R-squared:  0.008671 
## F-statistic: 6.615 on 1 and 641 DF,  p-value: 0.01034
# Model 3 - Predicting price by mileage and number of doors
model_3 <- lm(Price ~ Mileage + Doors, data = train_set)
summary(model_3)
## 
## Call:
## lm(formula = Price ~ Mileage + Doors, data = train_set)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -12642  -7503  -3000   5595  43576 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  2.945e+04  1.926e+03  15.292  < 2e-16 ***
## Mileage     -1.786e-01  4.744e-02  -3.764 0.000182 ***
## Doors       -1.242e+03  4.532e+02  -2.740 0.006308 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9713 on 640 degrees of freedom
## Multiple R-squared:  0.03165,    Adjusted R-squared:  0.02863 
## F-statistic: 10.46 on 2 and 640 DF,  p-value: 3.388e-05
# Create list of model formulas with combine_predictors()
# Use only the 4 first predictors (to save time)
# Limit the number of fixed effects (predictors) to 3, 
# Limit the biggest possible interaction to a 2-way interaction
# Limit the number of times a fixed effect is included to 1
model_formulas <- combine_predictors(
  dependent = "Price",
  fixed_effects = c("Mileage", "Cylinder",
                    "Doors", "Cruise"),
  max_fixed_effects = 3,
  max_interaction_size = 2,
  max_effect_frequency = 1)

# Output model formulas
model_formulas
##  [1] "Price ~ Cruise"                     
##  [2] "Price ~ Cylinder"                   
##  [3] "Price ~ Doors"                      
##  [4] "Price ~ Mileage"                    
##  [5] "Price ~ Cruise * Cylinder"          
##  [6] "Price ~ Cruise * Doors"             
##  [7] "Price ~ Cruise * Mileage"           
##  [8] "Price ~ Cruise + Cylinder"          
##  [9] "Price ~ Cruise + Doors"             
## [10] "Price ~ Cruise + Mileage"           
## [11] "Price ~ Cylinder * Doors"           
## [12] "Price ~ Cylinder * Mileage"         
## [13] "Price ~ Cylinder + Doors"           
## [14] "Price ~ Cylinder + Mileage"         
## [15] "Price ~ Doors * Mileage"            
## [16] "Price ~ Doors + Mileage"            
## [17] "Price ~ Cruise * Cylinder + Doors"  
## [18] "Price ~ Cruise * Cylinder + Mileage"
## [19] "Price ~ Cruise * Doors + Cylinder"  
## [20] "Price ~ Cruise * Doors + Mileage"   
## [21] "Price ~ Cruise * Mileage + Cylinder"
## [22] "Price ~ Cruise * Mileage + Doors"   
## [23] "Price ~ Cruise + Cylinder * Doors"  
## [24] "Price ~ Cruise + Cylinder * Mileage"
## [25] "Price ~ Cruise + Cylinder + Doors"  
## [26] "Price ~ Cruise + Cylinder + Mileage"
## [27] "Price ~ Cruise + Doors * Mileage"   
## [28] "Price ~ Cruise + Doors + Mileage"   
## [29] "Price ~ Cylinder * Doors + Mileage" 
## [30] "Price ~ Cylinder * Mileage + Doors" 
## [31] "Price ~ Cylinder + Doors * Mileage" 
## [32] "Price ~ Cylinder + Doors + Mileage"

# Create 5 fold columns with 4 folds each in the training set
train_set <- fold(train_set, k = 4, 
                  num_fold_cols = 5)
# Create list of fold column names
fold_cols <- paste0(".folds_", 1:5)
# Cross-validate the models with cvms
CV_results <- cross_validate(train_set, 
                             models = model_formulas,
                             fold_cols = fold_cols,
                             family = "gaussian")
# Select the best model by RMSE
# Order by RMSE
CV_results <- CV_results[order(CV_results$RMSE),]

# Select the 10 best performing models for printing
# (Feel free to view all the models)
CV_results_top10 <- head(CV_results, 10)

# Show metrics and model definition columns
# Use kable for a prettier output
kable(select_metrics(CV_results_top10), digits = 2)
# Evaluate the best model on the validation set with validate()
V_results <- validate(
  train_data = train_set, 
  test_data = valid_set, 
  models = "Price ~ Cruise * Cylinder + Mileage", 
  family = "gaussian")
valid_results <- V_results$Results
valid_model <- V_results$Models[[1]]

# Print the results
kable(select_metrics(valid_results), digits = 2)

# Print the model summary and interpret it
summary(valid_model)
## 
## Call:
## lm(formula = model_formula, data = train_set)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -10485  -5495  -1425   3494  34693 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      8993.2446  3429.9320   2.622  0.00895 ** 
## Cruise          -1311.6871  3585.6289  -0.366  0.71462    
## Cylinder         1809.5447   741.9185   2.439  0.01500 *  
## Mileage            -0.1569     0.0367  -4.274 2.21e-05 ***
## Cruise:Cylinder  1690.0768   778.7838   2.170  0.03036 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 7503 on 638 degrees of freedom
## Multiple R-squared:  0.424,  Adjusted R-squared:  0.4203 
## F-statistic: 117.4 on 4 and 638 DF,  p-value: < 2.2e-16