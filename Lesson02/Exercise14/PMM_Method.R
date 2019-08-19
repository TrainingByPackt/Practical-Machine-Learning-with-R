tail(PimaIndiansDiabetes_new)

impute_step1 <- mice(PimaIndiansDiabetes_new, m=5,maxit=30,meth='pmm',seed=50)

summary(impute_step1)
completedData <- complete(impute_step1,1)
tail(completedData)

