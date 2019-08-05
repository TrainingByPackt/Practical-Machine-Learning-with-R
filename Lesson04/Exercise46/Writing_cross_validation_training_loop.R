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
  # Make sure not to include the ".folds" column as a predictor!
  nn <- neuralnet(Class == "Good" ~ .,
                  cv_train_set[, c(9, 11:20)],
                  linear.output = FALSE)

  # Append error to the errors vector
  errors <- append(errors, nn$result.matrix[1])

  # Create one-hot encoding of Class variable
  true_labels <- ifelse(cv_test_set$Class == "Good", 1, 0)

  # Predict the class in the test set
  # It returns probabilities that the observations are "Good"
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
# different results, if, for instance, the folds were not exactly the same
# size.
average_error <- mean(errors)
average_error
## [1] 51.47703

average_accuracy <- mean(accuracies)
average_accuracy
## [1] 0.74375
 
