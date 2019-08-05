#Fetch the current date
current_date<-Sys.time()
current_date

## print the date
formatted_date <- as.POSIXlt(current_date)
formatted_date

#Fetch the year
year=format(formatted_date, "%Y")
year
 
#Fetch the month
month<-format(formatted_date, "%m")
month
 
#Fetch the date
day<-format(formatted_date, "%d")
day

#Fetch the day of week
weekday<-format(formatted_date, "%w")
weekday