
library(cluster)
data(votes.repub)
agn <- agnes(votes.repub)
agn
bannerplot(agn) 
pltree(agn)
