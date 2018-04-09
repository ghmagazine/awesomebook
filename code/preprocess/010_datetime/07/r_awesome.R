library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()
load_holiday_mst()

# 下記から本書掲載
# 休日マスタと結合
inner_join(reserve_tb, holiday_mst, by=c('checkin_date'='target_day'))
