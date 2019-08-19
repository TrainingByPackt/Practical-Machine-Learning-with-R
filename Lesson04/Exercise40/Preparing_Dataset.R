# Attaching the packages
library(caret)
library(groupdata2)

# Load the GermanCredit dataset
data(GermanCredit)

# See the structure of the dataset
str(GermanCredit[,1:10])

# Remove the Age column
GermanCredit$Age <- NULL
