library(mlbench)
library(caret)

data(PimaIndiansDiabetes)

library(randomForest)

random_forest = randomForest(Class~., data= PimaIndiansDiabetes)

# Create an importance based on mean decreasing gini
importance(random_forest)

varImp(random_forest)

