# Attach car
library(car)
cor(train_set[, c(3:5)])
##
##            beds     baths      sqft
## beds  1.0000000 0.6452788 0.7179578
## baths 0.6452788 1.0000000 0.7619998
## sqft  0.7179578 0.7619998 1.0000000
# Train a linear regression model 
# with all four predictors
lin_model_all_predictors <- lm(
  price~in_sacramento + sqft + beds + baths, 
  data = train_set)

# Apply the vif() function to the model object 
vif(lin_model_all_predictors)
## in_sacramento          sqft          beds         baths 
##      1.108431      3.133212      2.196416      2.515782
lin_model_2 <- lm(price ~ in_sacramento + sqft, 
                  data = train_set)
summary(lin_model_2)
## Call:
## lm(formula = price ~ in_sacramento + sqft, data = train_set)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -198778  -51380  -11981   35566  403189
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)    
## (Intercept)     43421.47    9118.38   4.762 2.31e-06 ***
## in_sacramento1 -35732.88    6306.19  -5.666 2.09e-08 ***
## sqft              131.09       4.29  30.558  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 82240 on 742 degrees of freedom
## Multiple R-squared:  0.6105, Adjusted R-squared:  0.6095 
## F-statistic: 581.6 on 2 and 742 DF,  p-value: < 2.2e-16
lin_model_3 <- lm(price ~ in_sacramento + sqft + beds, 
                  data = train_set)
summary(lin_model_3)
## Call:
## lm(formula = price ~ in_sacramento + sqft + beds, data = train_set)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -197285  -51124  -10338   32609  390503
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)     88084.399  12230.228   7.202 1.46e-12 ***
## in_sacramento1 -32276.138   6225.042  -5.185 2.79e-07 ***
## sqft              154.180      6.025  25.591  < 2e-16 ***
## beds           -26058.703   4861.568  -5.360 1.11e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 80740 on 741 degrees of freedom
## Multiple R-squared:  0.6251, Adjusted R-squared:  0.6235 
## F-statistic: 411.8 on 3 and 741 DF,  p-value: < 2.2e-16
lin_model_4 <- lm(
  price ~ in_sacramento + sqft + beds + baths, 
  data = train_set)
summary(lin_model_4)
## Call:
## lm(formula = price ~ in_sacramento + sqft + beds + baths, data = train_set)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -197062  -50856  -10504   32786  389848 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)     88552.649  12780.774   6.929 9.25e-12 ***
## in_sacramento1 -32331.816   6244.561  -5.178 2.90e-07 ***
## sqft              154.666      7.142  21.656  < 2e-16 ***
## beds           -25916.586   4991.630  -5.192 2.69e-07 ***
## baths            -838.448   6596.329  -0.127    0.899
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 80800 on 740 degrees of freedom
## Multiple R-squared:  0.6251, Adjusted R-squared:  0.623 
## F-statistic: 308.4 on 4 and 740 DF,  p-value: < 2.2e-16
lin_model_5 <- lm(price ~ in_sacramento + beds + baths, 
                  data = train_set)
summary(lin_model_5)
## Call:
## lm(formula = price ~ in_sacramento + beds + baths, data = train_set)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -271495  -65516  -18642   41358  519964
## 
## Coefficients:
##                Estimate Std. Error t value Pr(>|t|)    
## (Intercept)       38812      16060   2.417   0.0159 *  
## in_sacramento1   -58566       7825  -7.485 2.04e-13 ***
## beds              24695       5634   4.383 1.34e-05 ***
## baths             75745       7113  10.649  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 103200 on 741 degrees of freedom
## Multiple R-squared:  0.3875, Adjusted R-squared:  0.385 
## F-statistic: 156.2 on 3 and 741 DF,  p-value: < 2.2e-16