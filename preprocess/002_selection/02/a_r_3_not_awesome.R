library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%

  # filter関数にcheckin_dateの条件式を指定し、条件適合する行を抽出
  filter(checkin_date >= '2016-10-12' & checkin_date <= '2016-10-13')
