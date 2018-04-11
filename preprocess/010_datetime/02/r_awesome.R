library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
library(lubridate)

# reserve_datetimeをPOSIXct型に変換
reserve_tb$reserve_datetime_ct <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# reserve_datetimeをPOSIXlt型に変換
reserve_tb$reserve_datetime_lt <-
  as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# POSIXct型とDate型の場合、関数を利用して特定の日時要素を取り出す
# （内部で日時要素を取り出すための計算を行っている）
# POSIXlt型の場合、直接特定の日時要素を取り出せる

# 年を取得
year(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$year

# 月を取得
month(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$mon

# 日を取得
days_in_month(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$mday

# 曜日（0=日曜日、1＝月曜日）を数値で取得
wday(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$wday

# 曜日を文字列で取得
weekdays(reserve_tb$reserve_datetime_ct)

# 時刻の時を取得
hour(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$hour

# 時刻の分を取得
minute(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$min

# 時刻の秒を取得
second(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$sec

# 指定したフォーマットの文字列に変換
format(reserve_tb$reserve_datetime_ct, '%Y-%m-%d %H:%M:%S')
