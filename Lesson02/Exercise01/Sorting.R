#sorting a dataframe
data()
attach(PimaIndiansDiabetes)


# sort by glucose
sorted_data <- PimaIndiansDiabetes[order(glucose),] 
# View the output
head(sorted_data)


# sort by  glucose and  pressure
sorted_data <- PimaIndiansDiabetes[order( glucose,  pressure),]
head(sorted_data)


#sort in ascending order by glucose and descending order by pressure
sorted_data <- PimaIndiansDiabetes[order( glucose, - pressure),] 
head(sorted_data)


#Using the sort function to sort glucose
sort(glucose)

#Sort in descending order
sort(glucose,decreasing = TRUE)


#Using the rank function to rank the values of glucose
rank(glucose)


