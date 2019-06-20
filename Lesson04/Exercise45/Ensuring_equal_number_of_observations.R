
# Attach groupdata2
library(groupdata2)
# Set seed for reproducibility and easier comparison
set.seed(1)
# Partition with an equal number of observations (50) per class in 
# the development and validation sets
# The remaining observations will end up in a third partition, 
# which will be our training set
partitions_equal <- partition(GermanCredit, p = c(50, 50), cat_col = "Class")
dev_set_equal <- partitions_equal[[1]]
valid_set_equal <- partitions_equal[[2]]
train_set_equal <- partitions_equal[[3]]
# Count the number of observations from each class 
# in the training and test sets.
train_counts_equal <- table(train_set_equal$Class)
dev_counts_equal <- table(dev_set_equal$Class)
valid_counts_equal <- table(valid_set_equal$Class)
train_counts_equal
##  Bad Good 
##  200  600
dev_counts_equal
##  Bad Good 
##   50   50
valid_counts_equal
##  Bad Good 
##   50   50