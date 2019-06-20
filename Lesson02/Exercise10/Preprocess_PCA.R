# load the dataset
data(mtcars)

params <- preProcess(mtcars, method=c("center", "scale", "pca"))

# perform pca on the dataset using the parameters
new_dataset <- predict(params, mtcars)

# perform pca on the dataset using the parameters
new_dataset <- predict(params, mtcars)

