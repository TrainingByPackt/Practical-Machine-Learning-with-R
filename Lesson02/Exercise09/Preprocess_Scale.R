data(PimaIndiansDiabetes)
summary(PimaIndiansDiabetes[,1:2])
# to scale we will use scale keyword
params <- preProcess(PimaIndiansDiabetes[,1:2], method=c("scale"))
print(params)

#Scale the data
new_dataset <- predict(params, PimaIndiansDiabetes[,1:2])

# summarize the transformed dataset
summary(new_dataset)

