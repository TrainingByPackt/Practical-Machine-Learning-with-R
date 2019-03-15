#Skewness
install.packages('mlbench')	
library(mlbench)

#install.packages('mlbench')	
data(PimaIndiansDiabetes)
	
#Printing the skewness of the columns 
#Not skewed 
skewness(PimaIndiansDiabetes$glucose)

histogram(PimaIndiansDiabetes$glucose)

#Highly skewed 
skewness(PimaIndiansDiabetes$age)

histogram(PimaIndiansDiabetes$age)
