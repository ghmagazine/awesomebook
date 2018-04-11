library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
library(lubridate)

# reserve_datetimeをPOSIXct型に変換
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# reserve_dateをDate型に変換
reserve_tb$reserve_date <-
  as.Date(reserve_tb$reserve_datetime, format='%Y-%m-%d')

# reserve_datetimeに1日加える
reserve_tb$reserve_datetime + days(1)

# reserve_datetimeに1時間加える
reserve_tb$reserve_datetime + hours(1)

# reserve_datetimeに1分加える
reserve_tb$reserve_datetime + minutes(1)

# reserve_datetimeに1秒加える
reserve_tb$reserve_datetime + seconds(1)

# reserve_dateに1日加える
reserve_tb$reserve_date + days(1)
