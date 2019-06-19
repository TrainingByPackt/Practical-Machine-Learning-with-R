#Loading the library
library(caret)

# load the German Credit Data
data(GermanCredit)

# calculating the correlation matrix
correlationMatrix <- cor(GermanCredit[,1:9])

# printing the correlation matrix
print(correlationMatrix)

# finding the attributes that are highly corrected 
filterCorrelation <- findCorrelation(correlationMatrix, cutoff=0.5)

# print indexes of highly correlated fields
print(filterCorrelation)

print(correlationMatrix)

# finding the attributes that are highly corrected 
# print indexes of highly correlated fields
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5)
print(highlyCorrelated)

