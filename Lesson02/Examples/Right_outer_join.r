#Right Join
data1=head(PimaIndiansDiabetes)
data2=tail(PimaIndiansDiabetes)
merge(data1, data2, by='glucose',all.y=TRUE)