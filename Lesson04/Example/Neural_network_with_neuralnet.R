# Using Duration and Amount as predictors

# Attaching neuralnet
library(neuralnet)
# Set seed for reproducibility and easier comparison
set.seed(1)
# Classifying if class is "Good"
nn1 <- neuralnet(Class == "Good" ~ Duration + Amount,
                 train_set, linear.output = FALSE)
plot(nn1, rep = "best", fontsize = 10)
train_error <- nn1$result.matrix[1]
train_error

# Attach packages
library(neuralnet)
library(NeuralNetTools)
# Set seed for reproducibility and easier comparison
set.seed(1)
# Classifying if class is "Good"
# Using columns 11 to 20
# Notice that we choose the predictors by subsetting the data frame
# and use every column as predictor with the dot "~."
nn2 <- neuralnet(Class == "Good" ~ ., train_set[, c(9, 11:20)],
                 linear.output = FALSE)
plotnet(nn2, var_labs = FALSE)

train_error <- nn2$result.matrix[1]
train_error
## [1] 52.13454
