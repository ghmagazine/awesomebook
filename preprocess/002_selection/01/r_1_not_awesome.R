library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# reserve_tbの2次元配列の1次元目を空にすることで、すべての行を抽出
# reserve_tbの2次元配列の2次元目に数値ベクトルを指定することで、複数の列を抽出
reserve_tb[, c(1, 2, 3, 4, 5, 6, 7)]
