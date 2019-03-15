library(MASS)
box_cox = boxcox(PimaIndiansDiabetes$age ~ 1, lambda = seq(-6,6,0.1))

cox = data.frame(box_cox$x, box_cox$y)            

cox2 = cox[with(cox, order(-cox$box_cox.y)),] # Order the new data frame by decreasing y

cox2[1,]                                  # Display the lambda with the greatest

lambda = cox2[1, "box_cox.x"]                 # Extract that lambda

transformed_box_cox = (PimaIndiansDiabetes$age ^ lambda - 1)/lambda   # Transform the original data

#View histogram
histogram(transformed_box_cox)
