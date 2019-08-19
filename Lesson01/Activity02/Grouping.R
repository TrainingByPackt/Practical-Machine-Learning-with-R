#View the structure of the data
str(PimaIndiansDiabetesData)

#View the Summary of the data
summary(PimaIndiansDiabetesData)

#Perform Group by and view statistics for the columns
#Install the package
install.packages("psych")

library(psych) #Load package psych to use function describeBy
describeBy(PimaIndiansDiabetesData$pregnant, PimaIndiansDiabetesData$diabetes)
