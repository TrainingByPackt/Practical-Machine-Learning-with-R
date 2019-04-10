###Standardize

# Load Library caret
library(caret)

# load the dataset mtcars
data(mtcars)

# view the data
summary(mtcars[,1:2])

# to standardise we will scale and center
params <- preProcess(mtcars[,1:2], method=c("center", "scale"))

# transform the dataset
new_dataset <- predict(params, mtcars[,1:2])

# summarize the transformed dataset
summary(new_dataset)
