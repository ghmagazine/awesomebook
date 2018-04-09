library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%
  group_by(hotel_id) %>%

  # var関数にtotal_priceを指定し、分散値を算出
  # sd関数にtotal_priceを指定し、標準偏差値を算出
  # データ数が1件だったときにNAとなるので、
  # coalesce関数を利用して、NAの場合に0に置換
  summarise(price_var=coalesce(var(total_price), 0),
            price_std=coalesce(sd(total_price), 0))
