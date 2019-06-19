#PCA Analysis
data(PimaIndiansDiabetes) 

#Use the German Credit Data 
PimaIndiansDiabetes_subset <- PimaIndiansDiabetes[,1:8]

#Find out the Principal components
principal_components <- prcomp(x = PimaIndiansDiabetes_subset, scale. = T) 

#Print the principal components
print(principal_components)

