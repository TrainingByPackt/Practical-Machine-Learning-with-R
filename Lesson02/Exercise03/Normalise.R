# Load Library caret
library(caret)

# load the dataset mtcars
data(mtcars)


# view the data
summary(mtcars[,1:2])

# to normalise we will create a range
params <- preProcess(mtcars[,1:2], method=c("range"))

# transform the dataset using the parameters
new_dataset <- predict(params, mtcars[,1:2])


# summarize the transformed dataset
summary(new_dataset) 
