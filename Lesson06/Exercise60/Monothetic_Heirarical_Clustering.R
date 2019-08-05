library(cluster)
data(animals)
apply(animals,2, table) # simple overview
ma <- mona(animals)
ma
plot(ma)