# load the dataset
data(mtcars)

params <- preProcess(mtcars, method=c("center", "scale", "pca"))

# perform pca on the dataset using the parameters
new_dataset <- predict(params, mtcars)

# view the new dataset
summary(new_dataset)
