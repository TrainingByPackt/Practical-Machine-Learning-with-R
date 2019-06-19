data(GermanCredit)

GermanCredit_subset <- GermanCredit[,1:10]

library(randomForest)

random_forest = randomForest(Class~., data=GermanCredit_subset)

# Create an importance based on mean decreasing gini
importance(random_forest)

varImp(random_forest)

