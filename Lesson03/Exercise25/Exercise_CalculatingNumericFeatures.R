#Numeric Features

library(caret)
data(GermanCredit)

#See the structure of the dataset
str(GermanCredit)

#Calculate mean
mean =mean(GermanCredit$Amount) 

#Calculate standard deviation
standard_dev=sd(GermanCredit$Amount)  

#Calculate median
median=median(GermanCredit$Amount)

#Identify maximum
max=max(GermanCredit$Amount)

#Identify minimum
min=min(GermanCredit$Amount)

library(e1071)                    # install.packages('e1071')

skewness=skewness(GermanCredit$Amount)  
