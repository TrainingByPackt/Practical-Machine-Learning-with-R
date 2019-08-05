#Time series features
library(caret)

#Install caret if not installed
#install.packages('caret')

GermanCredit = read.csv("GermanCredit.csv")
duration<- GermanCredit$Duration #take the duration column

summary(duration)
library(ggplot2)
ggplot(data=GermanCredit, aes(x=GermanCredit$Duration)) +
  geom_density(fill='lightblue') +
  geom_rug() +
  labs(x='mean Duration')

  #Creating Bins
# set up boundaries for intervals/bins
breaks <- c(0,10,20,30,40,50,60,70,80)

# specify interval/bin labels
labels <- c("<10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80")

# bucketing data points into bins
bins <- cut(duration, breaks, include.lowest = T, right=FALSE, labels=labels)

# inspect bins
summary(bins)

#Ploting the bins
plot(bins, main="Frequency of Duration", ylab="Count of customers", xlab="Duration Bins(Months)",col="bisque")

