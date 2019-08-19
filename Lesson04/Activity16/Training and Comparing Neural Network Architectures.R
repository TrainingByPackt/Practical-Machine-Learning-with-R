# Attach the packages
library(groupdata2)
library(caret)
library(neuralnet)
library(mlbench)

# Set seed for reproducibility and easier comparison
set.seed(1)

# Load the PimaIndiansDiabetes2 dataset
PimaIndiansDiabetes2 <- read.csv("PimaIndiansDiabetes2.csv")

summary(PimaIndiansDiabetes2)

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
params <- preProcess(train_set[, 1:6], method = c("center", "scale"))

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
                                      mode="prec_recall", positive =
                                        "1")
  # Print the results for this model
  # Note: paste0() concatenates the strings
  # to (name of model + " on the dev...")
  print( paste0( names(models)[[i]], " on the development set: "))
  print(confusion_matrix)
}

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

plotnet(nn6, var_labs=FALSE)

