
library(cluster)
data(votes.repub)
agn <- agnes(votes.repub)
bannerplot(agn) 
pltree(agn)
