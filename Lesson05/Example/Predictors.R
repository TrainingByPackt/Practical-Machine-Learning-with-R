# Find scaling and centering parameters
params <- preProcess(train_set[, 3:5], 
                     method = c("center", "scale"))

# Make a copy of the dataset
standardized_data <- train_set

# Transform the dataset
standardized_data[, 3:5] <- predict(params, 
                                    standardized_data[, 3:5])

lin_model_7_2 <- lm(price ~ baths * in_sacramento + beds * sqft, 
                    data = standardized_data)
summary(lin_model_7_2)
