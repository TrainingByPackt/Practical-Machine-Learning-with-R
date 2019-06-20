
# Attach the packages
library(groupdata2)
library(caret)
library(neuralnet)
library(mlbench)

# Set seed for reproducibility and easier comparison
set.seed(1)

# Load the PimaIndiansDiabetes2 dataset
PimaIndiansDiabetes2 <- read.csv("PimaIndiansDiabetes2.csv")

# Handling missing data (quick solution)

# Assign/copy dataset to a new name
diabetes_data <- PimaIndiansDiabetes2

# Remove the triceps and insulin columns
diabetes_data$triceps <- NULL
diabetes_data$insulin <- NULL

# Remove all rows with NAs (missing data)
diabetes_data <- na.omit(diabetes_data)

# Partition into a training set and a validation set
partitions <- partition(diabetes_data, p = 0.8, cat_col = "diabetes")
train_set <- partitions[[1]]
valid_set <- partitions[[2]]

# Find scaling and centering parameters
# Note: We could also decide to do this inside the training loop!
params <- preProcess(train_set[, 1:6], method=c("center", "scale"))

# Transform the training set
train_set[, 1:6] <- predict(params, train_set[, 1:6])

# Transform the validation set
valid_set[, 1:6] <- predict(params, valid_set[, 1:6])

# Create folds for cross-validation
# Balance on the Class variable
train_set <- fold(train_set, k = 4, cat_col = "diabetes")
# Note: This creates a factor in the dataset called ".folds"
# Take care not to use this as a predictor 

## Cross-validation loop

# Change the model formula in the loop and run the below 
# for each model architecture you're testing

# Initialize vectors for collecting errors and accuracies
errors <- c()
accuracies <- c()

# Training loop
for (part in 1:4){

  # Assign the chosen fold as test set
  # and the rest of the folds as train set
  cv_test_set <- train_set[train_set$.folds == part,]
  cv_train_set <- train_set[train_set$.folds != part,]

  # Train neural network classifier
  # Make sure not to include the .folds column as a predictor!
  nn <- neuralnet(diabetes == "pos" ~ ., 
                  cv_train_set[, 1:7], 
			  linear.output = FALSE,
                  hidden=c(2,2))

  # Append error to errors vector
  errors <- append(errors, nn$result.matrix[1])

  # Create one-hot encoding of Class variable
  true_labels <- ifelse(cv_test_set$diabetes == "pos", 1, 0)

  # Predict the class in the test set
  # It returns probabilities that the observations are "pos"
  predicted_probabilities <- predict(nn, cv_test_set)
  predictions <- ifelse(predicted_probabilities > 0.5, 1, 0)

  # Calculate accuracy manually
  # Note: TRUE == 1, FALSE == 0
  cv_accuracy <- sum(true_labels == predictions) / length(true_labels)

  # Append the accuracy to the accuracies vector
  accuracies <- append(accuracies, cv_accuracy)

}

# Calculate average error and accuracy
# Note that we could also have gathered the predictions from all the 
# folds and calculated the accuracy only once. This could lead to slightly 
# different results, e.g. if the folds are not exactly the same size.

average_error <- mean(errors)
average_error
# The output is as follows:
## [1] 28.38503

average_accuracy <- mean(accuracies)
average_accuracy
# The output is as follows:
## [1] 0.7529813

# Once you have chosen the best model, train it on the entire training set
# and evaluate on the validation set

# Note that we set the stepmax, to make sure 
# it has enough training steps to converge
nn_best <- neuralnet(diabetes == "pos" ~ .,
                     train_set[, 1:7], 
 		     linear.output = FALSE,
                     hidden=c(2,2),
                     stepmax = 2e+05)

# Find the true labels in the validation set
valid_true_labels <- ifelse(valid_set$diabetes == "pos", 1, 0)

# Predict the classes in the validation set
predicted_probabilities <- predict(nn_best, valid_set)
predictions <- ifelse(predicted_probabilities > 0.5, 1, 0)

# Create confusion matrix
confusion_matrix <- confusionMatrix(as.factor(predictions), 
                                    as.factor(valid_true_labels), 
                                    mode="prec_recall", positive = "1")

# Print the results for this model
print("nn_best on the validation set:")
## [1] "nn_best on the validation set:"

print(confusion_matrix)
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  0  1
##          0 78 20
##          1 17 30
##                                           
##                Accuracy : 0.7448          
##                  95% CI : (0.6658, 0.8135)
##     No Information Rate : 0.6552          
##     P-Value [Acc > NIR] : 0.01302         
##                                           
##                   Kappa : 0.4271          
##  Mcnemar's Test P-Value : 0.74231         
##                                           
##               Precision : 0.6383          
##                  Recall : 0.6000          
##                      F1 : 0.6186          
##              Prevalence : 0.3448          
##          Detection Rate : 0.2069          
##    Detection Prevalence : 0.3241          
##       Balanced Accuracy : 0.7105          
##                                           
##        'Positive' Class : 1               
## 

plotnet(nn_best, var_labs=FALSE)
