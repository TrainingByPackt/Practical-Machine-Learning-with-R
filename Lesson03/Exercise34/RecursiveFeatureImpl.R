set.seed(7)
install.packages("e1071")
install.packages("randomForest")

library(e1071)
library(randomForest)

# load the library
library(mlbench)
library(caret)

# load the German Credit Data
data("GermanCredit")

# Use random forest as the method 
method_fn <- rfeControl(functions=rfFuncs, method="cv", number=9)

# run the Recursive Feature Elimination algorithm
output <- rfe(GermanCredit[,1:9], GermanCredit[,10], sizes=c(1:9), rfeControl=method_fn)

# print the output
print(output)
predictors(output)
