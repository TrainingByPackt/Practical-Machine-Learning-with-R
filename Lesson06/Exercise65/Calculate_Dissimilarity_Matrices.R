
library(cluster)
data(agriculture)
dist(agriculture) #Euclidean distance is the default
dist(agriculture, method="manhattan")
daisy(agriculture, metric = "euclidean", stand = FALSE)
daisy(agriculture, metric = "manhattan", stand = FALSE)