library(mlbench)
data(PimaIndiansDiabetes)
	
#Correlation Analysis between glucose and pressure

#plot(PimaIndiansDiabetes$glucose, PimaIndiansDiabetes$pressure, col="red", xlab = "Glucose", ylab = "Pressure", pch=16, main = "Pearson Correlation")

plot(PimaIndiansDiabetes$pregnant, PimaIndiansDiabetes$age, col="red", xlab = "Pregnant", ylab = "Age", pch=16, main = "Pearson Correlation")

data(Sonar)
	
plot(Sonar$V4, Sonar$V3, col="red", xlab = "v4", 
     ylab = "v3", pch=16, main = "Pearson Correlation")

