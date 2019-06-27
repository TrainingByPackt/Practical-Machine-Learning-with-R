lin_model_6 <- lm(price ~ in_sacramento + sqft + beds + sqft : beds, 
                  data = train_set)
summary(lin_model_6)
## 
## Call:
## lm(formula = price ~ in_sacramento + sqft + beds + sqft : beds, data = train_set)
## 
##     Min      1Q  Median      3Q     Max 
## -202169  -48471  -11623   33049  396985 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      1237.724  26124.893   0.047 0.962225    
## in_sacramento1 -30556.412   6187.792  -4.938 9.75e-07 ***
## sqft              211.963     16.515  12.835  < 2e-16 ***
## beds            -3190.095   7768.994  -0.411 0.681471    
## sqft:beds         -14.431      3.845  -3.753 0.000189 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 80040 on 740 degrees of freedom
## Multiple R-squared:  0.6321, Adjusted R-squared:  0.6301 
## F-statistic: 317.8 on 4 and 740 DF,  p-value: < 2.2e-16
