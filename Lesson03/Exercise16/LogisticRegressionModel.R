GermanCredit_subset <- GermanCredit[,1:10]
library(mlbench)

data(GermanCredit_subset)

data_lm = as.data.frame(GermanCredit_subset)

# Fit a logistic regression model
log_reg = glm(Class~.,GermanCredit_subset,family = "binomial")

library(caret)

# Using varImp() function
varImp(log_reg) 

