##Install the libraries if it is not present
#install.packages("lubridate",type="win.binary")

## Time Features
library(lubridate)

#Hour of Day
hour <- hour(formatted_date)

#Extract Minute
min <- minute(formatted_date)

