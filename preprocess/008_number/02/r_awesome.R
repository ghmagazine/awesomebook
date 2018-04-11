library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%
  mutate(total_price_log=log((total_price / 1000 + 1), 10))
