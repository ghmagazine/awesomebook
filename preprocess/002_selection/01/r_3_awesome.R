library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# dplyrパッケージを利用し、%>%によって、reserve_tbを次の行の関数に渡す
reserve_tb %>%

  # select関数の引数に抽出する列名を入力することによって、列を抽出
  select(reserve_id, hotel_id, customer_id, reserve_datetime,
         checkin_date, checkin_time, checkout_date) %>%

  # Rのdata.frameに変換(以降の例題では省略)
  as.data.frame()

