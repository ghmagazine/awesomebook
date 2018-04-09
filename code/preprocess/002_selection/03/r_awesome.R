library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# reserve_tbから50%サンプリング
sample_frac(reserve_tb, 0.5)
