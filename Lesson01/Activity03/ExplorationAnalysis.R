#Calculate correlations
correlation <- cor(PimaIndiansDiabetesData[,1:4])

#Round the values to the nearest 2 digit
round(correlation,2)

#Plot the pairs on a plot
pairs(PimaIndiansDiabetesData[,1:4])

# Load library
library(ggplot2)
boxplot <- ggplot(data=PimaIndiansDiabetesData, aes(x=diabetes, y=pregnant))
boxplot + geom_boxplot(aes(fill=diabetes)) + 
  ylab("Pregnant”) + ggtitle("Diabetes Data Boxplot") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)

  