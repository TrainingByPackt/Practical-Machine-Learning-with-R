
library(cluster)
data(votes.repub)
agn <- agnes(votes.repub)
pltree(agn)