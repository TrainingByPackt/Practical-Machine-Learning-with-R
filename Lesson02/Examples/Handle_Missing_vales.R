#Remove rows containing missing values
newdata <- na.omit(PimaIndiansDiabetes_new)
is.na(newdata)