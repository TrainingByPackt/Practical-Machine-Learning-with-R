
library(mlbench)
data("PimaIndiansDiabetes")

Subsetting Data
# select variables age, glucose, pressure
myvars <- c("age", "glucose", "pressure")
newdata <- PimaIndiansDiabetes[myvars]
head(newdata)

# another method
newdata <- PimaIndiansDiabetes[, 1:3]
head(newdata)

# select 1st and 5th through 9th variables
newdata <- PimaIndiansDiabetes[c(1,5:9)]
head(newdata)

# using subset function
newdata <- subset(PimaIndiansDiabetes,
 insulin >= 20 & age < 30,
 select=c(insulin, age))
head(newdata)
