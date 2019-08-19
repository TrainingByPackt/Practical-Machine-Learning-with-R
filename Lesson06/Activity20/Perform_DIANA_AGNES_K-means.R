
library(cluster)   
library(factoextra)
df <- read.csv("mtcars.csv")

rownames(df) <- df$X
df$X <- NULL

df <- na.omit(df)
df <- scale(df)
dv <- diana(df,metric = "manhattan", stand = TRUE)
plot(dv)
agn <- agnes(df)
pltree(agn)
fviz_nbclust(mtcars, kmeans, method = "wss") + geom_vline(xintercept = 4, linetype = 2)+labs(subtitle = "Elbow method")
k4 <- kmeans(df, centers = 4, nstart = 20)
fviz_cluster(k4, data = df)
