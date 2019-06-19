#Add rows with missing values
iris_new <- rbind(iris, c(1, 2,NA,NA,"setosa"))
iris_new <- rbind(iris_new, c(NA,NA,3,4,"setosa"))
iris_new <- rbind(iris_new, c(4,2,3,4,NA))


#Convert character to numeric
iris_new$Sepal.Length=as.numeric(iris_new$Sepal.Length)
iris_new$Sepal.Width=as.numeric(iris_new$Sepal.Width)
iris_new$Petal.Length=as.numeric(iris_new$Petal.Length)
iris_new$Petal.Width=as.numeric(iris_new$Petal.Width)

library(rpart)

class_mod <- rpart(Species ~ . - Sepal.Length, data=iris_new[!is.na(iris_new$Species), ], method="class", na.action=na.omit) 
# since Species is a factor


anova_mod <- rpart(Petal.Length ~ . - Sepal.Length, data=iris_new[!is.na(iris_new$Petal.Length), ], method="anova", na.action=na.omit)
# since Petal.Length is numeric.  


categoric_pred <- predict(class_mod, iris_new[is.na(iris_new$Species), ])
numeric_pred <- predict(anova_mod, iris_new[is.na(iris_new$Petal.Length), ])

categoric_pred
numeric_pred
