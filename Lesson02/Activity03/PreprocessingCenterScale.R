library(caret)
library(mlbench)
# load the dataset PimaIndiansDiabetes
data(PimaIndiansDiabetes)
library(dplyr)
# view data
summary(PimaIndiansDiabetes)
glimpse(PimaIndiansDiabetes)

# perform center operation to the dataset
params <- preProcess(PimaIndiansDiabetes, 
                     method=c("center","scale","pca"))

print(params)

# transform the dataset using the parameters
new_dataset <- predict(params, PimaIndiansDiabetes)
plot(PimaIndiansDiabetes[,1],PimaIndiansDiabetes[,2],col= c("red","blue"))
plot(new_dataset[,1], new_dataset[,2], col = c("red","blue"))
# summarize the transformed dataset
head(new_dataset)
summary(new_dataset)
PimaIndiansDiabetes[,1:2]
glimpse(new_dataset)
