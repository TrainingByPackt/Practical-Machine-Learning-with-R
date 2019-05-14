set.seed(9560)

oversampling <- upSample(x = PimaIndiansDiabetes[, -ncol(PimaIndiansDiabetes)],
                         y = PimaIndiansDiabetes$diabetes)                         

table(oversampling$Class)
