library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# roll_sum関数のためのライブラリ
library(RcppRoll)

reserve_tb %>%

  # データ行をcustomer_idごとにグループ化
  group_by(customer_id) %>%

  # customer_idごとにreserve_datetimeでデータを並び替え
  arrange(reserve_datetime) %>%

  # RcppRollのroll_sumによって、移動合計値を計算
  mutate(price_sum=roll_sum(total_price, n=3, align='right', fill=NA))
