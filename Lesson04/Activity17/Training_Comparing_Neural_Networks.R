
# Attach the packages
library(groupdata2)
library(caret)
library(neuralnet)
library(mlbench)

# Set seed for reproducibility and easier comparison
set.seed(1)

# Load the PimaIndiansDiabetes2 dataset
PimaIndiansDiabetes2 <-read.csv("PimaIndiansDiabetes2.csv")

summary(PimaIndiansDiabetes2)
# The summary is as follows:
##     pregnant         glucose         pressure         triceps     
##  Min.   : 0.000   Min.   : 44.0   Min.   : 24.00   Min.   : 7.00  
##  1st Qu.: 1.000   1st Qu.: 99.0   1st Qu.: 64.00   1st Qu.:22.00  
##  Median : 3.000   Median :117.0   Median : 72.00   Median :29.00  
##  Mean   : 3.845   Mean   :121.7   Mean   : 72.41   Mean   :29.15  
##  3rd Qu.: 6.000   3rd Qu.:141.0   3rd Qu.: 80.00   3rd Qu.:36.00  
##  Max.   :17.000   Max.   :199.0   Max.   :122.00   Max.   :99.00  
##                   NA's   :5       NA's   :35       NA's   :227  
##  
##     insulin            mass          pedigree           age       
##  Min.   : 14.00   Min.   :18.20   Min.   :0.0780   Min.   :21.00  
##  1st Qu.: 76.25   1st Qu.:27.50   1st Qu.:0.2437   1st Qu.:24.00  
##  Median :125.00   Median :32.30   Median :0.3725   Median :29.00  
##  Mean   :155.55   Mean   :32.46   Mean   :0.4719   Mean   :33.24  
##  3rd Qu.:190.00   3rd Qu.:36.60   3rd Qu.:0.6262   3rd Qu.:41.00  
##  Max.   :846.00   Max.   :67.10   Max.   :2.4200   Max.   :81.00  
##  NA's   :374      NA's   :11               
##                       
##  diabetes 
##  neg:500  
##  pos:268        

# Assign/copy dataset to a new name
diabetes_data <- PimaIndiansDiabetes2

# Remove the triceps and insulin columns
diabetes_data$triceps <- NULL
diabetes_data$insulin <- NULL

# Remove all rows with NAs (missing data)
diabetes_data <- na.omit(diabetes_data)

# Partition with same ratio of each class in all three partitions
partitions <- partition(diabetes_data, p = c(0.6, 0.2), 
				  cat_col = "diabetes")
train_set <- partitions[[1]]
dev_set <- partitions[[2]]
valid_set <- partitions[[3]]

# Find scaling and centering parameters
params <- preProcess(train_set[, 1:6], method=c("center", "scale"))

# Transform the training set
train_set[, 1:6] <- predict(params, train_set[, 1:6])

# Transform the development set
dev_set[, 1:6] <- predict(params, dev_set[, 1:6])

# Transform the validation set
valid_set[, 1:6] <- predict(params, valid_set[, 1:6])

# Training multiple neural nets
nn4 <- neuralnet(diabetes == "pos" ~ ., train_set, 
                 linear.output = FALSE, hidden = c(3))
nn5 <- neuralnet(diabetes == "pos" ~ ., train_set, 
                 linear.output = FALSE, hidden = c(2,1))
nn6 <- neuralnet(diabetes == "pos" ~ ., train_set, 
                 linear.output = FALSE, hidden = c(3,2))

# Put the model objects into a list
models <- list("nn4"=nn4,"nn5"=nn5,"nn6"=nn6)


# Evaluating each model on the dev_set

# Create one-hot encoding of diabetes variable
dev_true_labels <- ifelse(dev_set$diabetes == "pos", 1, 0)

# Evaluate one model at a time in a loop, to avoid repeating the code
for (i in 1:length(models)){
  
  # Predict the classes in the development set
  dev_predicted_probabilities <- predict(models[[i]], dev_set)
  dev_predictions <- ifelse(dev_predicted_probabilities > 0.5, 1, 0)
  
  # Create confusion Matrix
  confusion_matrix <- confusionMatrix(as.factor(dev_predictions), 
                                      as.factor(dev_true_labels), 
                                      mode="prec_recall", positive = "1")
  
  # Print the results for this model
  # Note: paste0() concatenates the strings 
  # to (name of model + " on the dev...")
  print( paste0( names(models)[[i]], " on the development set: "))
  print(confusion_matrix)
  
}

## [1] "nn4 on the development set: "
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  0  1
##          0 79 19
##          1 16 30
##                                           
##                Accuracy : 0.7569          
##                  95% CI : (0.6785, 0.8245)
##     No Information Rate : 0.6597          
##     P-Value [Acc > NIR] : 0.007584        
##                                           
##                   Kappa : 0.4505          
##  Mcnemar's Test P-Value : 0.735317        
##                                           
##               Precision : 0.6522          
##                  Recall : 0.6122          
##                      F1 : 0.6316          
##              Prevalence : 0.3403          
##          Detection Rate : 0.2083          
##    Detection Prevalence : 0.3194          
##       Balanced Accuracy : 0.7219          
##                                           
##        'Positive' Class : 1               
##                                           
## [1] "nn5 on the development set: "
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  0  1
##          0 77 16
##          1 18 33
##                                          
##                Accuracy : 0.7639         
##                  95% CI : (0.686, 0.8306)
##     No Information Rate : 0.6597         
##     P-Value [Acc > NIR] : 0.004457       
##                                          
##                   Kappa : 0.4793         
##  Mcnemar's Test P-Value : 0.863832       
##                                          
##               Precision : 0.6471         
##                  Recall : 0.6735         
##                      F1 : 0.6600         
##              Prevalence : 0.3403         
##          Detection Rate : 0.2292         
##    Detection Prevalence : 0.3542         
##       Balanced Accuracy : 0.7420         
##                                          
##        'Positive' Class : 1              
##                                          
## [1] "nn6 on the development set: "
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  0  1
##          0 76 14
##          1 19 35
##                                           
##                Accuracy : 0.7708          
##                  95% CI : (0.6935, 0.8367)
##     No Information Rate : 0.6597          
##     P-Value [Acc > NIR] : 0.002528        
##                                           
##                   Kappa : 0.5019          
##  Mcnemar's Test P-Value : 0.486234        
##                                           
##               Precision : 0.6481          
##                  Recall : 0.7143          
##                      F1 : 0.6796          
##              Prevalence : 0.3403          
##          Detection Rate : 0.2431          
##    Detection Prevalence : 0.3750          
##       Balanced Accuracy : 0.7571          
##                                           
##        'Positive' Class : 1               
## 

# As the nn6 model has the highest accuracy and F1 score, it is the best model.

# Create one-hot encoding of Class variable
valid_true_labels <- ifelse(valid_set$diabetes == "pos", 1, 0)

# Predict the classes in the validation set
predicted_probabilities <- predict(nn6, valid_set)
predictions <- ifelse(predicted_probabilities > 0.5, 1, 0)

# Create confusion Matrix
confusion_matrix <- confusionMatrix(as.factor(predictions), 
                                    as.factor(valid_true_labels), 
                                    mode="prec_recall", positive = "1")

# Print the results for this model
# Note that by separating two function calls by ";"
# we can have multiple calls per line
print("nn6 on the validation set:"); print(confusion_matrix)

## [1] "nn6 on the validation set:"
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  0  1
##          0 70 16
##          1 25 35
##                                           
##                Accuracy : 0.7192          
##                  95% CI : (0.6389, 0.7903)
##     No Information Rate : 0.6507          
##     P-Value [Acc > NIR] : 0.04779         
##                                           
##                   Kappa : 0.4065          
##  Mcnemar's Test P-Value : 0.21152         
##                                           
##               Precision : 0.5833          
##                  Recall : 0.6863          
##                      F1 : 0.6306          
##              Prevalence : 0.3493          
##          Detection Rate : 0.2397          
##    Detection Prevalence : 0.4110          
##       Balanced Accuracy : 0.7116          
##                                           
##        'Positive' Class : 1               
## 

plotnet(nn6, var_labs=FALSE)
