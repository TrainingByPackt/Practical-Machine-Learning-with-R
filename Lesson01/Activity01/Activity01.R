# Load the dataset
library(mlbench)
data(PimaIndiansDiabetes)

#Assign it to a local variable for further use
PimaIndiansDiabetesData<- PimaIndiansDiabetes

#Display the first five rows
head(PimaIndiansDiabetesData)

levels(PimaIndiansDiabetesData$diabetes)
library(ggplot2)
barplot <- ggplot(data= PimaIndiansDiabetesData, aes(x=age))
plot()
barplot + geom_histogram(binwidth=0.2, color="black", aes(fill=diabetes))  + ggtitle("Histogram of Age")

