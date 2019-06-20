# Load Library caret
library(caret)

# load the dataset PimaIndiansDiabetes
data(PimaIndiansDiabetes)


# view the data
summary(PimaIndiansDiabetes[,1:2])

# to normalise we will create a range
params <- preProcess(PimaIndiansDiabetes[,1:2], method=c("range"))

# transform the dataset using the parameters
new_dataset <- predict(params, PimaIndiansDiabetes[,1:2])


# summarize the transformed dataset
summary(new_dataset) 
