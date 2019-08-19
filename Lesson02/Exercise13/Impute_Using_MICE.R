#View the NA
tail(PimaIndiansDiabetes_new)

library(mice)
impute_step1 = mice(PimaIndiansDiabetes_new)
imputed_data = complete(impute_step1)

#View the imputed values
tail(imputed_data)

