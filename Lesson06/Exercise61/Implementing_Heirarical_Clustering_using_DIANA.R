
library(cluster)
data(agriculture)
dv <- diana(agriculture,metric = "manhattan", stand = TRUE)
print(dv)
plot(dv)
str(as.dendrogram(dv))
