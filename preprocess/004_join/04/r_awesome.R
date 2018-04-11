library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
library(tidyverse)

# 計算対象の年月のデータフレームを作成
month_mst <- data.frame(year_month=
  # 2017-01-01、2017-02-01, 2017-03-01を生成し、format関数で形式を年月に変換
  # (日付のデータ型については、「第10章 日時型」で詳しく解説)
  format(seq(as.Date('2017-01-01'), as.Date('2017-03-01'), by='months'),
         format='%Y%m')
)

# 顧客IDと計算対象のすべての年月が結合したテーブル
customer_mst <-

  # すべての顧客IDと年月マスタを全結合
  merge(customer_tb %>% select(customer_id), month_mst) %>%

  # mergeで指定した結合キーのデータ型がカテゴリ型になっているので、文字型に戻す
  # (カテゴリ型については、「第9章 カテゴリ型」で詳しく解説)
  mutate(customer_id=as.character(customer_id),
         year_month=as.character(year_month))

# 合計利用金額を月ごとに計算
left_join(
  customer_mst,

  # 予約テーブルに年月の結合キーを準備
  reserve_tb %>%
    mutate(checkin_month = format(as.Date(checkin_date), format='%Y%m')),

  # 同じcustomer_idと年月を結合
  by=c('customer_id'='customer_id', 'year_month'='checkin_month')
) %>%

  # customer_idと年月で集約
  group_by(customer_id, year_month) %>%

  # 合計金額を算出
  summarise(price_sum=sum(total_price)) %>%

  # 予約レコードがなかった場合の合計金額を値なしから0に変換
  replace_na(list(price_sum=0))
