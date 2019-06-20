set.seed(2)

imbalance_data <- twoClassSim(1000, intercept = -15, linearVars = 5)
table(imbalance_data$Class)


ctrl <- trainControl(method = "repeatedcv",
                     number = 10,
                     repeats = 5,
                     summaryFunction = twoClassSummary,
                     classProbs = TRUE)

					 
ctrl$sampling <- "smote"

smote_fit <- train(Class ~ .,
                   data = imbalance_data,
                   method = "gbm",
             verbose = FALSE,
                   metric = "ROC",
                   trControl = ctrl)

				   