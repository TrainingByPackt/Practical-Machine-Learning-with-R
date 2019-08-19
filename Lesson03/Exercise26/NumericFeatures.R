library(caret)
data(GermanCredit)

#See the structure of the dataset
str(GermanCredit)

#Calculate mean
mean <- mean(GermanCredit$Amount) 
mean

#Calculate standard deviation
standard_dev <- sd(GermanCredit$Amount)
standard_dev

#Calculate median
median <- median(GermanCredit$Amount)
median

#Identify maximum
max <- max(GermanCredit$Amount)
max

#Identify minimum
min <- min(GermanCredit$Amount)
min

library(e1071)                    # load e1071 
skewness <- skewness(GermanCredit$Amount)
skewness

