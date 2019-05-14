library(caret)

tail(iris_new[,1:4])

#Impute
iris_caret = predict(preProcess(iris_new[,1:4],method = 'medianImpute'),newdata = iris_new[,1:4])

#View the imputed values
tail(iris_caret)
