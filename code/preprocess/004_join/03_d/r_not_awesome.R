library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
library(tidyr)

# row_number関数でreserve_datetimeを利用するために、POSIXct型に変換
# (「第10章 日時型」で詳しく解説)
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# 過去90日間の合計予約金額を計算したテーブル
sum_table <-

  # reserve_datetimeの日付を確認せずに、同じcustomer_idのデータ行同士をすべて結合
  inner_join(
    reserve_tb %>%
      select(reserve_id, customer_id, reserve_datetime),
    reserve_tb %>%
      select(customer_id, reserve_datetime, total_price) %>%
      rename(reserve_datetime_before=reserve_datetime),
    by='customer_id') %>%

  # checkinの日付を比較して、90日以内のデータが結合されているデータ行のみ抽出
  # 60*60*24*90は、60秒*60分*24時間*90日を意味し、90日間分の秒数を計算
  # (日付のデータ型については、「第10章 日時型」で詳しく解説)
  filter(reserve_datetime > reserve_datetime_before &
           reserve_datetime - 60 * 60 * 24 * 90 <= reserve_datetime_before) %>%
  select(reserve_id, total_price) %>%

  # reserve_idごとにtotal_priceの合計値を計算
  group_by(reserve_id) %>%
  summarise(total_price_90d=sum(total_price)) %>%
  select(reserve_id, total_price_90d)

# 計算した合計値を結合し、元のテーブルに情報を付与
# 合計値が存在しないレコードの合計値の値を、replace_naを利用して0に変更
left_join(reserve_tb, sum_table, by='reserve_id') %>%
  replace_na(list(total_price_90d=0))
