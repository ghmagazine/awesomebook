library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%

  # select関数の引数に抽出する列名を入力することによって、列を抽出
  # starts_with関数を利用して、先頭にcheckが付いている列を抽出
  select(reserve_id, hotel_id, customer_id, reserve_datetime,
         starts_with('check'))
