# Inner Join
data1=head(PimaIndiansDiabetes)
data2=head(PimaIndiansDiabetes)
merge(data1, data2, by='glucose')