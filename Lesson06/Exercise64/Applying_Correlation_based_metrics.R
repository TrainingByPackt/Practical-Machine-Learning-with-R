
install.packages("factoextra")
library(factoextra)
df <- swiss
pearson_dist <- get_dist(df, method = "pearson")
round(as.matrix(pearson_dist)[1:5, 1:5], 1)
spearman_dist <- get_dist(df, method = "spearman")
round(as.matrix(spearman_dist)[1:5, 1:5], 1)
kendall_dist <- get_dist(df, method = "kendall")
round(as.matrix(kendall_dist)[1:5, 1:5], 1)