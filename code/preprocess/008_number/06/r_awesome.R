library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production()

# 下記から本書掲載
# prcomp関数によって、主成分分析を実行（アルゴリズムは特異値分解法）
# scaleをFALSEにすると、正規化を行わず主成分分析を実行
pca <- prcomp(production_tb %>% select(length, thickness), scale=FALSE)

# summary関数によって、各次元の下記の値を確認
# Proportion of Variance:寄与率
# Cumulative Proportion:累積寄与率
summary(pca)

# 主成分分析の適用結果はxに格納
pca_values <- pca$x

# predict関数を利用し、同じ次元圧縮処理を実行
pca_newvalues <-
  predict(pca, newdata=production_tb %>% select(length, thickness))
