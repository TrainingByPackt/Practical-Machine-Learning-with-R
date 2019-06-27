# Attach packages
library(rPref)
library(ggplot2)
library(knitr)
# Set seed for reproducibility and easier comparison
set.seed(3)
# Create random set of model evaluations
# runif() samples random numbers between 0 and 1
evaluated_models <- data.frame("Model" = c(1:20),
                               "Precision" = runif(20),
                               "Recall" = runif(20))
# Order the data frame by the two metrics
evaluated_models <- evaluated_models[order(evaluated_models$Precision, 
                                           evaluated_models$Recall,
                                           decreasing = TRUE),]

# Inspect the simulated results
kable(evaluated_models, digits = 2)

# Find the Pareto front / set
front <- psel(evaluated_models, 
              pref = high("Precision") * high("Recall"))

# Print the Pareto front
kable(front, digits = 2)
# Create ggplot object 
# with precision on the x-axis and recall on the y-axis
ggplot(evaluated_models, aes(x = Precision, y = Recall)) + 
  
  # Add the models as points
  geom_point(shape = 1) + 
  
  # Add the non-dominated models as larger points
  geom_point(data = front, size = 3) + 
  
  # Add a line to visualize the Pareto front
  geom_step(data = front, direction = "vh") +
  
  # Add the light theme
  theme_light()