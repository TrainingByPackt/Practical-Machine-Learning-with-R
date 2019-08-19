#Adding new features to a R datadrame
library(caret)

data(GermanCredit)


#Assign the value to the new field
GermanCredit$NewField1 <- 1
str(GermanCredit)

#Copy an existing column into a new column
GermanCredit$NewField2 <- GermanCredit$Purpose.Repairs 

str(GermanCredit)