library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%

  # group_by関数によって、集約単位をhotel_idに指定
  group_by(hotel_id) %>%

  # summarise関数を使って集約処理を指定
  # n関数を使って、予約数をカウント
  # n_distinct関数にcustomer_idを指定して、customer_idのユニークカウント
  summarise(rsv_cnt=n(),
            cus_cnt=n_distinct(customer_id))
