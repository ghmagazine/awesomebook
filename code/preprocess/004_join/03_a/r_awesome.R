library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%

  # group_byによって、customer_idごとにデータをグループ化
  group_by(customer_id) %>%

  # LAG関数を利用し、2件前のtotal_priceをbefore_priceとして取得
  # LAG関数によって参照する際のグループ内のデータをreserve_datetimeの古い順に指定
  mutate(before_price=lag(total_price, n=2,
                          order_by=reserve_datetime, default=NA))
