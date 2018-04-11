library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# lubridateライブラリ
# (parse_date_time, parse_date_time2, fast_strptimeのライブラリ)
library(lubridate)

# POSIXct型に変換
as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
as.POSIXct(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
           format='%Y-%m-%d %H:%M:%S')

# POSIXlt型に変換
as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
as.POSIXlt(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
           format='%Y-%m-%d %H:%M:%S')

# parse_date_time関数によって、POSIXct型に変換
parse_date_time(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')
parse_date_time(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
                orders='%Y-%m-%d %H:%M:%S')

# parse_date_time2関数によって、POSIXct型に変換
parse_date_time2(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')
parse_date_time2(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
                 orders='%Y-%m-%d %H:%M:%S')

# strptime関数によって、POSIXltに変換
strptime(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
strptime(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
         orders='%Y-%m-%d %H:%M:%S')

# fast_strptime関数によって、POSIXlt型に変換
fast_strptime(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
fast_strptime(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
              format='%Y-%m-%d %H:%M:%S')

# Date型に変換
as.Date(reserve_tb$reserve_datetime, format='%Y-%m-%d')
as.Date(reserve_tb$checkin_date, format='%Y-%m-%d')
