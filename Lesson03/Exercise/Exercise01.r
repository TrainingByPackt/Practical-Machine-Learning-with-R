# Generating Features 
# Date Features

#Fetch the current date
current_date=Sys.time()

## print the date
formatted_date <- as.POSIXlt(current_date)

#Fetch the year
year <- format(formatted_date, "%Y")

#Fetch the month
month <- format(formatted_date, "%m")

#Fetch the date
day <- format(formatted_date, "%d")

#Fetch the day of week
weekday <- format(formatted_date, "%w")
