# Attach car
library(car)
cor(train_set[, c(3:5)])

# Train a linear regression model 
# with all four predictors
lin_model_all_predictors <- lm(
  price~in_sacramento + sqft + beds + baths, 
  data = train_set)

# Apply the vif() function to the model object 
vif(lin_model_all_predictors)

lin_model_2 <- lm(price ~ in_sacramento + sqft, 
                  data = train_set)
summary(lin_model_2)

lin_model_3 <- lm(price ~ in_sacramento + sqft + beds, 
                  data = train_set)
summary(lin_model_3)

lin_model_4 <- lm(
  price ~ in_sacramento + sqft + beds + baths, 
  data = train_set)
summary(lin_model_4)

lin_model_5 <- lm(price ~ in_sacramento + beds + baths, 
                  data = train_set)
summary(lin_model_5)
