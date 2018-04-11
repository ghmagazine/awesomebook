library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%

  # as.Date関数によって、文字列を日付型に変換
  # （第9章「9-1 文字列、数値から日時型、日付型への変換」で解説)
  # between関数によって、checkin_dateの値の範囲指定
  filter(between(as.Date(checkin_date),
                 as.Date('2016-10-12'), as.Date('2016-10-13')))
