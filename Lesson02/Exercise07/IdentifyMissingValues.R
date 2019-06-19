#Handling missing values

#Add rows with missing values
iris_new <- rbind(iris, c(1, 2,NA,NA,"setosa"))
iris_new <- rbind(iris_new, c(NA,NA,3,4,"setosa"))

#Convert character to numeric
iris_new$Sepal.Length=as.numeric(iris_new$Sepal.Length)
iris_new$Sepal.Width=as.numeric(iris_new$Sepal.Width)
iris_new$Petal.Length=as.numeric(iris_new$Petal.Length)
iris_new$Petal.Width=as.numeric(iris_new$Petal.Width)

#Identifying missing values
#List the rows containing missing values
iris_new[!complete.cases(iris_new),]

is.na(iris_new) 
tail(is.na(iris_new) )

library(mice)
md.pattern(newdata)

