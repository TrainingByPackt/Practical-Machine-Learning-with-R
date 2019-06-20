# Attach neuralnet
library(neuralnet)
# Set seed for reproducibility and easy comparison
set.seed(1)
# Classifying if class is "Good"
nn3 <- neuralnet(Class == "Good" ~ ., train_set[, c(9, 11:20)],
 linear.output = FALSE, hidden = c(2,2))

plotnet(nn3, var_labs = FALSE)
# Print the training error
train_error <- nn3$result.matrix[1]
train_error

## [1] 48.42343