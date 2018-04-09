library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# row_number関数で並び替えるために、データ型を文字列からPOSIXct型に変換
# （「第10章 日時型で解説」）
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

reserve_tb %>%

  # 集約単位の指定はgroup_by関数を利用
  group_by(customer_id) %>%

  # mutate関数によって、新たな列log_noを追加
  # row_number関数によって、予約日時を基準とした順位を計算
  mutate(log_no=row_number(reserve_datetime))
