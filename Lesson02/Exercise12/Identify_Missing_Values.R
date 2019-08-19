#Handling missing values

library(mlbench)
data("PimaIndiansDiabetes")

#Adding NA values
PimaIndiansDiabetes_new <- rbind(
  PimaIndiansDiabetes,c(1, 212,NA,NA,3,44,0.45,23,"neg"))
PimaIndiansDiabetes_new <- rbind(
  PimaIndiansDiabetes_new,c(1, 212,NA,NA,3,44,0.45,23,"pos"))

#Convert character to numeric
PimaIndiansDiabetes_new$pregnant=as.numeric(
  PimaIndiansDiabetes_new$pregnant)
PimaIndiansDiabetes_new$glucose=as.numeric(
  PimaIndiansDiabetes_new$glucose)
PimaIndiansDiabetes_new$pressure=as.numeric(
  PimaIndiansDiabetes_new$pressure)
PimaIndiansDiabetes_new$triceps=as.numeric(
  PimaIndiansDiabetes_new$triceps)
PimaIndiansDiabetes_new$insulin=as.numeric(
  PimaIndiansDiabetes_new$insulin)
PimaIndiansDiabetes_new$mass=as.numeric(
  PimaIndiansDiabetes_new$mass)
PimaIndiansDiabetes_new$pedigree=as.numeric(
  PimaIndiansDiabetes_new$pedigree)
PimaIndiansDiabetes_new$age=as.numeric(
  PimaIndiansDiabetes_new$age)
PimaIndiansDiabetes_new$diabetes=as.numeric(
  PimaIndiansDiabetes_new$diabetes)


#Identifying missing values
#List the rows containing missing values
PimaIndiansDiabetes_new[
  !complete.cases(
    PimaIndiansDiabetes_new),]

is.na(PimaIndiansDiabetes_new)

tail(is.na(PimaIndiansDiabetes_new) )

library(mice)
md.pattern(PimaIndiansDiabetes_new)

