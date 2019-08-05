

# Set seed for reproducibility and easy comparison
set.seed(1)
# Attach doParallel and 
# register four CPU cores
library(doParallel)
registerDoParallel(4)
# Create baseline evaluations of the in_sacramento variable
# in the validation set
gaussian_baselines <- baseline(
  test_data = valid_set, 
  train_data = train_set, 
  dependent_col = "price", 
  n = 100, 
  family = "gaussian", 
  parallel = TRUE)

# Show the summarized results
gaussian_baselines$summarized_metrics
## # A tibble: 9 x 9
##   Measure     RMSE     MAE   r2m   r2c    AIC   AICc    BIC `Training Rows`
##   <chr>      <dbl>   <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>           <dbl>
## 1 Mean     142928. 107071.     0     0  9637.  9637.  9644.            366.
## 2 Median   142735. 106992.     0     0  9638.  9638.  9646.            365 
## 3 SD         1187.    676.     0     0  5420.  5420.  5421.            206.
## 4 IQR        1229.    557.     0     0  9664.  9664.  9666.            367.
## 5 Max      146942. 110573.     0     0 19325. 19325. 19334.            733 
## 6 Min      140801. 106230.     0     0   725.   726.   728.             27 
## 7 NAs           0       0      0     0     0      0      0               0 
## 8 INFs          0       0      0     0     0      0      0               0 
## 9 All_rows 142721. 106998.     0     0 19641. 19641. 19650.            745