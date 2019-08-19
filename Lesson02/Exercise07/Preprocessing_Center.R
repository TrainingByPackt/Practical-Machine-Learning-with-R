# Load the dataset.
library(caret)
library(mlbench)
# load the dataset PimaIndiansDiabetes
data(PimaIndiansDiabetes)

# view data
summary(PimaIndiansDiabetes[,1:2])
 
# perform center operation to the dataset
params <- preProcess(PimaIndiansDiabetes[,1:2], method=c("center"))

# transform the dataset using the parameters
new_dataset <- predict(params, PimaIndiansDiabetes[,1:2])
# summarize the transformed dataset
summary(new_dataset)

