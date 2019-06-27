
# Attach ggplot2
library(ggplot2)
# Assign/copy the training set to a new name
plotting_data <- train_set
# Use the model to predict prices in the training set
plotting_data$predicted_price <- predict(lin_model, train_set)
# Create ggplot object and specify the data and x,y axes
ggplot(data = plotting_data, 
       mapping = aes(x = in_sacramento, y = price)) + 
  # Add the training set observations as points
  geom_point(color = '#00004f', size = 0.4) + 
  # Add the predictions as a line
  # Notice that we convert in_sacramento to the 
  # type "numeric", as this allows us to draw the 
  # line in-between the two binary values
  geom_line(color = '#d8007a', 
            aes(x = as.numeric(in_sacramento), 
                y = predicted_price)) + 
  # Add a theme to make our plot prettier
  theme_light()
# Create ggplot object and specify the data and x,y axes
ggplot(data = plotting_data, 
       mapping = aes(x = in_sacramento, y = price)) + 
  # Add violin plot of the training data
  geom_violin(color = '#00004f', size = 0.4) + 
  
  # Add the training data as points
  geom_point(color = '#00004f', size = 0.4) + 
  
  # Add the predictions as a line
  # Notice that we convert in_sacramento to the 
  # type "numeric", as this allows us to draw the 
  # line in-between the two binary values
  geom_line(color = '#d8007a', 
            aes(x = as.numeric(in_sacramento), 
                y = predicted_price)) + 
  
  # Add a theme to make our plot prettier
  theme_light()