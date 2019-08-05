

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
##  [1] "price ~ baths"                              
##  [2] "price ~ beds"                               
##  [3] "price ~ in_sacramento"                      
##  [4] "price ~ sqft"                               
##  [5] "price ~ baths * beds"                       
##  [6] "price ~ baths * in_sacramento"              
##  [7] "price ~ baths * sqft"                       
##  [8] "price ~ baths + beds"                       
##  [9] "price ~ baths + in_sacramento"              
## [10] "price ~ baths + sqft"                       
## [11] "price ~ beds * in_sacramento"               
## [12] "price ~ beds * sqft"                        
## [13] "price ~ beds + in_sacramento"               
## [14] "price ~ beds + sqft"                        
## [15] "price ~ in_sacramento * sqft
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
                     
## 
## Call:
## lm(formula = "price ~ baths * in_sacramento + beds * sqft", data = train_set)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -217093  -47986  -10551   33501  399965 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)          -38995.37   29818.83  -1.308   0.1914    
## baths                 11786.48    8049.75   1.464   0.1436    
## in_sacramento1        20807.25   19003.95   1.095   0.2739    
## beds                   2242.42    8047.44   0.279   0.7806    
## sqft                    218.39      17.11  12.763  < 2e-16 ***
## baths:in_sacramento1 -25478.69    8895.65  -2.864   0.0043 ** 
## beds:sqft               -16.83       3.92  -4.295 1.98e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 79700 on 738 degrees of freedom
## Multiple R-squared:  0.6361, Adjusted R-squared:  0.6332 
## F-statistic: 215.1 on 6 and 738 DF,  p-value: < 2.2e-16