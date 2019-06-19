# Load the dataset.
library(caret)
# load the dataset mtcars
data(mtcars)

# view data
summary(mtcars[,1:2])
 
# perform center operation to the dataset
params <- preProcess(mtcars[,1:2], method=c("center"))

# transform the dataset using the parameters
new_dataset <- predict(params, mtcars[,1:2])
# summarize the transformed dataset
summary(new_dataset)

