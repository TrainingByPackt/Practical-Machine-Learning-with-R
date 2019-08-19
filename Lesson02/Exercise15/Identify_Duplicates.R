#Adding duplicate values
PimaIndiansDiabetes_new <- rbind(
  PimaIndiansDiabetes,c(1, 93,70,31,0,30.4,0.315,23,"pos"))
PimaIndiansDiabetes_new <- rbind(
  PimaIndiansDiabetes_new,c(1, 93,70,31,0,30.4,0.315,23,"pos"))
PimaIndiansDiabetes_new <- rbind(
  PimaIndiansDiabetes_new,c(1, 93,70,31,0,30.4,0.315,23,"pos"))

#Identify Duplicates
duplicated(PimaIndiansDiabetes_new)

#Display the duplicates
PimaIndiansDiabetes_new[duplicated(PimaIndiansDiabetes_new),]

#Display the unique values of the list of duplicates
unique(PimaIndiansDiabetes_new[duplicated(PimaIndiansDiabetes_new),])

#Display the unique values
unique(PimaIndiansDiabetes_new)
