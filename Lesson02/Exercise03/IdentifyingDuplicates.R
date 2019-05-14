#Identify Duplicates
duplicated(iris)

#Display the duplicates
iris[duplicated(iris),]

#Display the unique values of the list of duplicates
unique(iris[duplicated(iris),])

#Display the unique values
unique(iris)
