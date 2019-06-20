
# Attach caret
library(caret)
# Create a one-hot encoding of the Class variable
# ifelse() takes the arguments: "If x, then a, else b"
true_labels <- ifelse(dev_set$Class == "Good", 1, 0)
# Predict the class in the dev set
# It returns probabilities that the observations are "Good"
predicted_probabilities <- predict(nn, dev_set)
predictions <- ifelse(predicted_probabilities > 0.5, 1, 0)
# Create confusion matrix
confusion_matrix <- confusionMatrix(as.factor(predictions),										      as.factor(true_labels), 
                                    mode="prec_recall", positive = "1")
confusion_matrix
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