library(MASS)
box_cox = boxcox(PimaIndiansDiabetes$age ~ 1, lambda = seq(-6,6,0.1))

cox = data.frame(box_cox$x, box_cox$y)            

# Order the new data frame by decreasing y
cox2 = cox[with(cox, order(-cox$box_cox.y)),] 

# Display the lambda with the greatest      
cox2[1,]                                  

# Extract that lambda
lambda = cox2[1, "box_cox.x"]                 

# Transform the original data
transformed_box_cox = (PimaIndiansDiabetes$age ^ lambda - 1)/lambda   

#View histogram
histogram(transformed_box_cox)
