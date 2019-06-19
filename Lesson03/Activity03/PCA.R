data(GermanCredit)

#Use the German Credit Data 
GermanCredit_subset <- GermanCredit[,1:9]

#Find out the Principal components
principal_components <- prcomp(x = GermanCredit_subset, scale. = T)

#Print the principal components
print(principal_components)

