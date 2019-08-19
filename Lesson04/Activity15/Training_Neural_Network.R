# Attach the packages
library(caret)
library(groupdata2)
library(neuralnet)
library(NeuralNetTools)

# Set seed for reproducibility and easier comparison
set.seed(1)

# Load the German Credit dataset
GermanCredit <-read.csv("GermanCredit.csv")

# Remove the Age column
GermanCredit$Age <- NULL

# Partition with same ratio of each class in all three partitions
partitions <- partition(GermanCredit, p = c(0.6, 0.2), cat_col = "Class")
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

# Train the neural network classifier
nn <- neuralnet(Class == "Good" ~ InstallmentRatePercentage + 
			ResidenceDuration + NumberExistingCredits, 
                train_set, linear.output = FALSE)

# Plot the network
plotnet(nn, var_labs=FALSE)

# The output is as follows:
train_error <- nn$result.matrix[1]
train_error

## [1] 62.15447
