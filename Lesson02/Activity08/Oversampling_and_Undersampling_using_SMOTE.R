set.seed(2)
imbalance_data <- twoClassSim(1000, intercept = -5, linearVars = 5)
table(imbalance_data$Class)

set.seed(9560)
undersampling <- downSample(x = imbalance_data[, -ncol(imbalance_data)],
                            y = imbalance_data$Class)
table(undersampling$Class) 

set.seed(9560)
oversampling <- upSample(x = imbalance_data[, -ncol(imbalance_data)],
                         y = imbalance_data$Class)                         
table(oversampling$Class)

