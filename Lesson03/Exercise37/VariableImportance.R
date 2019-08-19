library(mlbench)
library(caret)
library(randomForest)

data(PimaIndiansDiabetes)

random_forest <- randomForest(diabetes ~., data= PimaIndiansDiabetes)

# Create an importance based on mean decreasing gini
importance(random_forest)

varImp(random_forest)
