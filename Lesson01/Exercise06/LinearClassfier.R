# load the package
library(caret)
data(GermanCredit)

#Subset the data
GermanCredit_Subset=GermanCredit[,1:10]


# fit model
fit <- lda(Class~., data=GermanCredit_Subset)

# summarize the fit
summary(fit)

# make predictions
predictions <- predict(fit, GermanCredit_Subset[,1:10])$class

# summarize accuracy
table(predictions, GermanCredit_Subset$Class)

# make predictions
predictions <- predict(fit, GermanCredit_Subset)

# summarize accuracy
rmse <- mean((GermanCredit_Subset$Duration - predictions)^2)
print(rmse)
