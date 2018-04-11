library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
library(lubridate)

# reserve_datetimeをPOSIXct型に変換
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# checkin_datetimeをPOSIXct型に変換
reserve_tb$checkin_datetime <-
  as.POSIXct(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
             format='%Y-%m-%d %H:%M:%S')

# 年の差分を計算（月以下の日時要素は考慮しない）
year(reserve_tb$checkin_datetime_lt) - year(reserve_tb$reserve_datetime)

# 月の差分を取得（日以下の日時要素は考慮しない）
(year(reserve_tb$checkin_datetime) * 12
 + month(reserve_tb$checkin_datetime)) -
(year(reserve_tb$reserve_datetime) * 12
 + month(reserve_tb$reserve_datetime))

# 日単位で差分を計算
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='days')

# 時間単位で差分を計算
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='hours')

# 分単位で差分を計算
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='mins')

# 秒単位で差分を計算
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='secs')
