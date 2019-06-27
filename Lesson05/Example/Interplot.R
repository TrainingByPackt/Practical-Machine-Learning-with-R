lin_model_6_2 <- lm(price ~ in_sacramento + sqft * beds, 
                    data = train_set)
# Attach interplot
library(interplot)

# Plot the effect of size 
# depending on the number of bedrooms
interplot(lin_model_6, "sqft", "beds", hist = TRUE) +
  
  # Add labels to the axes
  labs(x = "Number of bedrooms", y = "Price") +
  
  # Add a theme to make our plot prettier
  theme_light()

# Plot the effect of number of bedrooms 
# depending on size
interplot(lin_model_6, "beds", "sqft", hist = TRUE) + 
  
  # Add labels to the axes
  labs(x = "Size in square feet", y = "Price") +
  
  # Add a theme to make our plot prettier
  theme_light()
