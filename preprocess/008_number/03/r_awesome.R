library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
customer_tb %>%
  mutate(age_rank=as.factor(floor(age / 10) * 10))
