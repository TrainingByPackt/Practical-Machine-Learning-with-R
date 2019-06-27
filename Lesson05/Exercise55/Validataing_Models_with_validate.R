
# Train the model on the entire training set 
# and test it on the validation set.
validation <- validate(
  train_data = train_set, 
  test_data = valid_set, 
  models = "price ~ baths * in_sacramento + beds * sqft",
  family = "gaussian")
valid_results <- validation$Results
valid_model <- validation$Models[[1]]
kable(select_metrics(valid_results), digits = 2)
summary(valid_model)
## 
## Call:
## lm(formula = model_formula, data = train_set)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -209993  -46950  -12796   33713  553773 
## 
## Coefficients:
##                        Estimate Std. Error t value Pr(>|t|)    
## (Intercept)          -58024.456  29367.835  -1.976 0.048551 *  
## baths                 23083.792   7865.568   2.935 0.003441 ** 
## in_sacramento1        29453.042  18898.087   1.559 0.119539    
## beds                   6095.281   7811.066   0.780 0.435441    
## sqft                    209.351     17.326  12.083  < 2e-16 ***
## baths:in_sacramento1 -30085.305   8904.927  -3.379 0.000767 ***
## beds:sqft               -17.465      3.912  -4.464 9.29e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 79520 on 738 degrees of freedom
## Multiple R-squared:  0.6181, Adjusted R-squared:  0.615 
## F-statistic: 199.1 on 6 and 738 DF,  p-value: < 2.2e-16