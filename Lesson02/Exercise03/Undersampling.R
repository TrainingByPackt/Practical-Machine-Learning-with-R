install.packages("mlbench")
library(mlbench)
#data()
data(PimaIndiansDiabetes)

summary(PimaIndiansDiabetes$diabetes)
set.seed(9560)
undersampling <- downSample(
  x = PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)],
  y = PimaIndiansDiabetes$diabetes)
table(undersampling$Class)
