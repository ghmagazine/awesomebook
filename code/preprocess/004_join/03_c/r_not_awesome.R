library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# row_number関数でreserve_datetimeを利用するために、POSIXct型に変換
# (「第10章 日時型」で詳しく解説)
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

reserve_tb %>%
  group_by(customer_id) %>%
  arrange(reserve_datetime) %>%

  # １〜3件前のtotal_priceの合計をlag関数によって計算
  # if_else関数とrank関数を組み合わせて、何件合計したかを判定
  # order_by=reserve_datetimeの指定は、事前に並び替えられているので必須ではない
  # 合計した件数が0だった場合、0で割っているためprice_avgがNANとなる
  mutate(price_avg=
           (  lag(total_price, 1, order_by=reserve_datetime, default=0)
            + lag(total_price, 2, order_by=reserve_datetime, default=0)
            + lag(total_price, 3, order_by=reserve_datetime, default=0))
           / if_else(row_number(reserve_datetime) > 3,
                     3, row_number(reserve_datetime) - 1))
