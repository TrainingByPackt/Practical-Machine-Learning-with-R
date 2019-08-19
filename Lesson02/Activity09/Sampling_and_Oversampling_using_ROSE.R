#Load the library
library(caret)
library(ROSE)

#load the dataset
data(GermanCredit)

#View samples
head(GermanCredit)
str(GermanCredit)

#View the imbalanced data
summary(GermanCredit$Class)


balanced_data <- ROSE(Class ~ ., data  = stagec,seed=3)$data                         
table(balanced_data$Class)
