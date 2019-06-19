#Load the outlier library
library(outliers)

#Detect outliers
outlier(iris_new[,1:4])


#This detects outliers from the other side
outlier(iris_new[,1:4],opposite=TRUE)

#View the outliers
boxplot(iris_new[,1:4])

