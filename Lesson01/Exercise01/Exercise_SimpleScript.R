# Print a
print("Hi")

# Set the working directory
setwd('D:/GitHub/Practical-Machine-Learning-with-R/Lesson01')

#Read data from a CSV file
data = read.csv("mydata.csv")  
data

#Create a new row in the dataframe
data2 = rbind(data,list(1,2,3))
data2
