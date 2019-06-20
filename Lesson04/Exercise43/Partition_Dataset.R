
# Attach groupdata2
library(groupdata2)
# Set seed for reproducibility and easier comparison
set.seed(1)
# Simple partitioning
# Note that we only need to specify the 2 first partition sizes 
# as the remaining observations are put into a third partition.
partitions <- partition(GermanCredit, p = c(0.6, 0.2))
# This returns a list with three data frames.
train_set <- partitions[[1]]
dev_set <- partitions[[2]]
valid_set <- partitions[[3]]
# Count the number of observations from each class 
# in the training and test sets.
train_counts <- table(train_set$Class)
dev_counts <- table(dev_set$Class)
valid_counts <- table(valid_set$Class)
train_counts
##  Bad Good 
##  188  412
dev_counts
##  Bad Good 
##   60  140
valid_counts
##  Bad Good 
##   52  148
train_counts/max(train_counts)
##       Bad      Good 
## 0.4563107 1.0000000
dev_counts/max(dev_counts)
##       Bad      Good 
## 0.4285714 1.0000000
valid_counts/max(valid_counts)
##       Bad      Good 
## 0.3513514 1.0000000