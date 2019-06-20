library(caret)
set.seed(2)

imbalance_data <- twoClassSim(1000, intercept = -15, linearVars = 5)

table(imbalance_data$Class)

balanced_data <- ROSE(Class ~ ., data  = imbalance_data,seed=3)$data                         
table(balanced_data$Class)

