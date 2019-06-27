
# Attaching the packages
library(caret) # GermanCredit
library(groupdata2) # partition()

# Load the German Credit dataset
data("GermanCredit")

# Remove the Age column
GermanCredit$Age <- NULL

# Partition into train, dev and valid sets.
partitions <- partition(GermanCredit, p = c(0.6, 0.2), cat_col = "Class")

# Assign each partition to a variable name
train_set <- partitions[[1]]
dev_set <- partitions[[2]]
valid_set <- partitions[[3]]

# Count the number of observations from each class 
# in the training and test sets.
train_counts <- table(train_set$Class)
dev_counts <- table(dev_set$Class)
valid_counts <- table(valid_set$Class)

# Print the counts

train_counts
## Bad Good 
## 180  420 

dev_counts
## Bad Good 
##  60  140

valid_counts
## Bad Good 
##  60  140

# Print the ratios of the classes

train_counts/max(train_counts)
##       Bad      Good 
## 0.4285714 1.0000000

dev_counts/max(dev_counts)
##       Bad      Good 
## 0.4285714 1.0000000

valid_counts/max(valid_counts)
##       Bad      Good 
## 0.4285714 1.0000000
