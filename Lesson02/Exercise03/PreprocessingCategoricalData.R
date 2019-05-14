#Categorical Variable
iris_new$Species = factor(iris_new$Species,levels = c('setosa','versicolor','virginica'), labels = c(1,2,3))
iris_new$Species
