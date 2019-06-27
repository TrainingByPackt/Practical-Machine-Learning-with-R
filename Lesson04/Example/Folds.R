# Attach groupdata2
library(groupdata2)
# Set seed for reproducibility and easier comparison
set.seed(1)
# Partition into a training set and a validation set
partitions <- partition(GermanCredit, p = 0.8, cat_col = "Class")
train_set <- partitions[[1]]
valid_set <- partitions[[2]]

# Note: We could also decide to do this inside the training loop!
params <- preProcess(train_set[, 1:6], method = c("center", "scale"))

train_set[, 1:6] <- predict(params, train_set[, 1:6])
# Transform the validation set
valid_set[, 1:6] <- predict(params, valid_set[, 1:6])

# Create folds for cross-validation
# Again balanced on the Class variable
train_set <- fold(train_set, k = 4, cat_col = "Class")
