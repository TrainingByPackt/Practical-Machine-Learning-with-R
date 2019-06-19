library(caret)
data(GermanCredit)

# fit model
GermanCredit_Subset=GermanCredit[,1:10]
# fit model
fit <- lm(Duration~., GermanCredit_Subset)

# summarize the fit
summary(fit)

# make predictions
predictions <- predict(fit, GermanCredit_Subset)

# summarize accuracy
rmse <- mean((GermanCredit_Subset$Duration - predictions)^2)
print(rmse)

