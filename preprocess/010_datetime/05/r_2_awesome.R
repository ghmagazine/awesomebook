library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# reserve_datetimeをPOSIXlt型に変換
reserve_tb$reserve_datetime_lt <-
  as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# 月の数字を季節に変換する関数
to_season <-function(month_num){
  case_when(
    month_num >= 3 & month_num < 6  ~ 'spring',
    month_num >= 6 & month_num < 9  ~ 'summer',
    month_num >= 9 & month_num < 12 ~ 'autumn',
    TRUE                            ~ 'winter'
  )
}

# 季節に変換
reserve_tb$reserve_datetime_season <-
  sapply(reserve_tb$reserve_datetime_lt$mon, to_season)

# カテゴリ型に変換
reserve_tb$reserve_datetime_season <-
  factor(reserve_tb$reserve_datetime_season,
         levels=c('spring', 'summer', 'autumn', 'winter'))
