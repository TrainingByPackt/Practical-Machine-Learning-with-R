library(mlbench)
data(PimaIndiansDiabetes)

#Correlation Analysis between glucose and pressure
plot(PimaIndiansDiabetes$glucose, PimaIndiansDiabetes$pressure, col="red", xlab = "Glucose", ylab = "Pressure", pch=16, main = "Pearson Correlation")

data(Sonar)

plot(Sonar$V4, Sonar$V3, col="red", xlab = "V4", 
     ylab = "V3", pch=16, main = "Pearson Correlation")
