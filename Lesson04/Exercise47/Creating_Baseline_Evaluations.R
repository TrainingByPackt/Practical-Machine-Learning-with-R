 
# Attach caret
library(caret)
# Create one-hot encoding of Class variable
true_labels <- ifelse(dev_set$Class == "Good", 1, 0)
# The number of predictions to make 
num_total_predictions <- 200  # Alternatively: length(true_labels)
# All "Good"
good_predictions <- rep(1, num_total_predictions)
# Create confusion Matrix
confusion_matrix_good <- confusionMatrix(as.factor(good_predictions),									      as.factor(true_labels), 
                                            mode="prec_recall", 
								positive = "1")
confusion_matrix_good
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction   0   1
##          0   0   0
##          1  60 140
##                                           
##                Accuracy : 0.7             
##                  95% CI : (0.6314, 0.7626)
##     No Information Rate : 0.7             
##     P-Value [Acc > NIR] : 0.5348          
##                                           
##                   Kappa : 0               
##  Mcnemar's Test P-Value : 2.599e-14       
##                                           
##               Precision : 0.7000          
##                  Recall : 1.0000          
##                      F1 : 0.8235          
##              Prevalence : 0.7000          
##          Detection Rate : 0.7000          
##    Detection Prevalence : 1.0000          
##       Balanced Accuracy : 0.5000          
##                                           
##        'Positive' Class : 1               
## 
# All "Bad"
bad_predictions <- rep(0, num_total_predictions)
Create a confusion matrix and inspect the results:
# Create confusion Matrix
confusion_matrix_bad <- confusionMatrix(as.factor(bad_predictions),									     as.factor(true_labels),
                                           mode="prec_recall",
							     positive = "1")
confusion_matrix_bad
## Confusion Matrix and Statistics
##
##           Reference
## Prediction   0   1
##          0  60 140
##          1   0   0
##                                          
##                Accuracy : 0.3            
##                  95% CI : (0.2374, 0.3686)
##     No Information Rate : 0.7            
##     P-Value [Acc > NIR] : 1               
##                                           
##                   Kappa : 0               
##  Mcnemar's Test P-Value : <2e-16          
##                                           
##               Precision :  NA             
##                  Recall : 0.0             
##                      F1 :  NA             
##              Prevalence : 0.7             
##          Detection Rate : 0.0             
##    Detection Prevalence : 0.0             
##       Balanced Accuracy : 0.5             
##                                           
##        'Positive' Class : 1               
# Set seed for reproducibility
set.seed(1)
# The number of evaluations to do
num_evaluations <- 100
# Repeat the true labels vector 100 times
true_labels_100 <- rep(true_labels, num_evaluations)
# Random predictions 
# Draw random predictions (either 1 or 2, hence the "-1")
random_predictions <- sample.int(2, 
				   size = num_total_predictions * num_evaluations, 
                         replace = TRUE) - 1
head(random_predictions)
## [1] 0 0 1 1 0 1
# Average number of times predicting "Good"
sum(random_predictions) / num_evaluations
## [1] 99.59
# Create confusion Matrix
confusion_matrix_random <- confusionMatrix(as.factor(random_predictions), 
                                           as.factor(true_labels_100), 
                                           mode="prec_recall", 
                                           positive = "1")
confusion_matrix_random
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    0    1
##          0 3020 7021
##          1 2980 6979
##                                          
##                Accuracy : 0.5            
##                  95% CI : (0.493, 0.5069)
##     No Information Rate : 0.7            
##     P-Value [Acc > NIR] : 1              
##                                          
##                   Kappa : 0.0015         
##  Mcnemar's Test P-Value : <2e-16         
##                                          
##               Precision : 0.7008         
##                  Recall : 0.4985         
##                      F1 : 0.5826         
##              Prevalence : 0.7000         
##          Detection Rate : 0.3489         
##    Detection Prevalence : 0.4980         
##       Balanced Accuracy : 0.5009         
##                                          
##        'Positive' Class : 1              
## 

