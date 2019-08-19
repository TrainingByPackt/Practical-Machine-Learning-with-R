install.packages("rpart")
library(rpart)
library(caret)
set.seed(10)
	
data(GermanCredit)

GermanCredit_subset <- GermanCredit[,1:10]

#Train a rpart model
rPartMod <- train(Class ~ ., data=GermanCredit_subset, method="rpart")

#Find variable importance
rpartImp <- varImp(rPartMod)

#Print variable importance
print(rpartImp)

#Plot top 5 variable importance 
plot(rpartImp, top = 5, main='Variable Importance')

