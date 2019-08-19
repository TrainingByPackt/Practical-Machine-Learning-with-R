#Load the outlier library
library(outliers)

mtcars = read.csv("mtcars.csv")

#Detect outliers
outlier(mtcars)

#This detects outliers from the other side
outlier(mtcars,opposite=TRUE)

#View the outliers
boxplot(mtcars)

