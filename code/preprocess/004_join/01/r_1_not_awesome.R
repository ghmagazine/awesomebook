library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# reserve_tableとhotel_tbをhotel_idが等しいデータ同士で内部結合
inner_join(reserve_tb, hotel_tb, by='hotel_id') %>%
  
  # people_numが1かつis_businessがTrueのデータのみ抽出
  filter(people_num == 1, is_business)
