
#View the NA
tail(iris_new)
data(mlbench)
install.packages("mice")
library(mice)

impute_step1 = mice(iris_new)
imputed_data = complete(impute_step1)

#View the imputed values
tail(imputed_data)
