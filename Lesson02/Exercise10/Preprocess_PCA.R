# load the dataset
data(PimaIndiansDiabetes)

params <- preProcess(PimaIndiansDiabetes, method=c("center", "scale", "pca"))

# perform pca on the dataset using the parameters
new_dataset <- predict(params, PimaIndiansDiabetes)

# view the new dataset
summary(new_dataset)

library(dplyr)
glimpse(PimaIndiansDiabetes)
glimpse(new_dataset)