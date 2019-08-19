set.seed(9)
# loading the libraries
library(mlbench)
library(caret)

# load the German Credit dataset
data("GermanCredit")


#Setting parameters for training
control <- trainControl(method="repeatedcv", number=10, repeats=3)

# training the model
model <- train(Class~., data=GermanCredit[,1:10], method="lvq", preProcess="scale", trControl=control)


# Getting the variable importance
importance <- varImp(model, scale=FALSE)

# print the variable importance
print(importance)


# plot the result
plot(importance)

print(importance)