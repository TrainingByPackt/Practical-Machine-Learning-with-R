install.packages("rpart")
install.packages("randomForest")
set.seed(10)

library(caret)
library(mlbench)

data(PimaIndiansDiabetes)
PimaIndiansDiabetes_subset <- PimaIndiansDiabetes[,1:9]
PimaIndiansDiabetes_subset

#Train a rpart model
rPartMod <- train(diabetes ~ ., data=PimaIndiansDiabetes_subset, method="rpart")

#Find variable importance
rpartImp <- varImp(rPartMod)

#Print variable importance
print(rpartImp)

#Plot top 5 variable importance 
plot(rpartImp, top = 5, main='Variable Importance')
