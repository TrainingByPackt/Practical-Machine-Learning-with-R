library(caret)
library(mlbench)
#Install caret if not installed
#install.packages('caret')

data(PimaIndiansDiabetes)
age<-PimaIndiansDiabetes$age

summary(age)
#Creating Bins
# set up boundaries for intervals/bins
breaks <- c(0,10,20,30,40,50,60,70,80)

# specify interval/bin labels
labels <- c("<10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80")

bins <- cut(age, breaks, include.lowest = T, right=FALSE, labels=labels)
summary(bins)

plot(bins, main="Binning for Age",  ylab="Total Count of People",col="bisque",xlab="Age",ylim=c(0,450))

