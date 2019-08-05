library(cluster)   
library(factoextra) # used for visualization 
# unlike earlier where we used it for correlation
df <- read.csv("USArrests.csv")

rownames(df) <- df$X
df$X <- NULL

df <- scale(df)

k3 <- kmeans(df, centers = 3, nstart = 20)
str(k3)
k3

fviz_cluster(k3, data = df)
install.packages("NbClust")
library(NbClust)
fviz_nbclust(df, kmeans, method = "wss") + 
  geom_vline(xintercept = 4, linetype = 2) + 
  labs(subtitle = "Elbow method")
