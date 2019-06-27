# Find scaling and centering parameters for the fist 6 columns
params <- preProcess(train_set[, 1:6], method = c("center", "scale"))

# Transform the training set
train_set[, 1:6] <- predict(params, train_set[, 1:6])

# Transform the development set
dev_set[, 1:6] <- predict(params, dev_set[, 1:6])

# Transform the validation set
valid_set[, 1:6] <- predict(params, valid_set[, 1:6])
