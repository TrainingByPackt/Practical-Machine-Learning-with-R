#Load the outlier library
library(outliers)

#Detect outliers
outlier(PimaIndiansDiabetes[,1:4])


#This detects outliers from the other side
outlier(PimaIndiansDiabetes[,1:4],opposite=TRUE)

#View the outliers
boxplot(PimaIndiansDiabetes[,1:4])

