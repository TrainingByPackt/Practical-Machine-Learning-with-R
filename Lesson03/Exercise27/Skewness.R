library(mlbench)
library(lattice)
library(caret)
library(e1071)
data(Sonar)

skewness(Sonar$V4)
histogram(Sonar$V4,xlab=”V4”)
