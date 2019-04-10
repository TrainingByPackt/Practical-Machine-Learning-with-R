data(mtcars)

summary(mtcars[,1:2])

# to scale we will use scale keyword
params <- preProcess(mtcars[,1:2], method=c("scale"))


# summarize the transformed dataset
summary(new_dataset)
