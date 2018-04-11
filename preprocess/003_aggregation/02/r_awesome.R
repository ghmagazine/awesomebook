library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%

  # group_byにhotel_idとpeople_numの組み合わせを指定
  group_by(hotel_id, people_num) %>%

  # sum関数をtotal_priceに適用して、売上合計金額を算出
  summarise(price_sum=sum(total_price))
