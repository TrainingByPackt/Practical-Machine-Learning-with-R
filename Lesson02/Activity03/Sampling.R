library(caret)


ms<-read.csv('mushrooms.csv')
summary(ms$bruises)


set.seed(9560) 
undersampling <- downSample(x = ms[, -ncol(ms)], y = ms$bruises) 
table(undersampling$bruises) 


set.seed(9560)
oversampling <- upSample(x = ms[, -ncol(ms)],y = ms$bruises)                          
table(oversampling$bruises)

