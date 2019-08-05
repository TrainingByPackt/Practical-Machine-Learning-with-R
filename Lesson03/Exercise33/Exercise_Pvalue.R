library(caret)

#Calculating P-Value
component=cor.test(Sonar$V4, Sonar$V3)
print(component)

#Print the P value 
component$p.value

#Print the Correlation 
component$estimate
