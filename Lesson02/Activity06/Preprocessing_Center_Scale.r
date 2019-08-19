###Standardize

# Load Library caret
library(caret)
library(mlbench)

# load the dataset PimaIndiansDiabetes
data(PimaIndiansDiabetes)


# view the data
summary(PimaIndiansDiabetes[,1:2])
# to standardise we will scale and center
params <- preProcess(PimaIndiansDiabetes[,1:2], method=c("center", "scale"))


# transform the dataset
new_dataset <- predict(params, PimaIndiansDiabetes[,1:2])


# summarize the transformed dataset
summary(new_dataset)

