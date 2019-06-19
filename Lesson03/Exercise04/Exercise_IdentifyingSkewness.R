#Skewness
install.packages('mlbench')	
library(mlbench)

#install.packages('mlbench')	
data(PimaIndiansDiabetes)
	
#Printing the skewness of the columns 
#Not skewed 
skewness(PimaIndiansDiabetes$glucose)
histogram(PimaIndiansDiabetes$glucose,xlab="Glucose Concentration")

#Highly skewed 
skewness(PimaIndiansDiabetes$age)
histogram(PimaIndiansDiabetes$age,xlab="Age(in years)")

#Log Transformation
transformed_data=log(PimaIndiansDiabetes$age)

#View histogram
histogram(transformed_data,xlab="Transformed Age(In years)")
