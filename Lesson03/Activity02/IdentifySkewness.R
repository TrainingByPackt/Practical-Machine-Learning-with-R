#Skewness
library(mlbench)
PimaIndiansDiabetes = read.csv("PimaIndiansDiabetes.csv")

#Printing the skewness of the columns 
#Not skewed 
skewness(PimaIndiansDiabetes$glucose)


histogram(PimaIndiansDiabetes$glucose,xlab="Glucose Concentration")
#Highly skewed 
skewness(PimaIndiansDiabetes$age)

histogram(PimaIndiansDiabetes$age)

