library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# reserve_tbの2次元配列の2次元目に文字ベクトルを指定することで、指定した名前の列を抽出
reserve_tb[, c('reserve_id', 'hotel_id', 'customer_id', 'reserve_datetime',
               'checkin_date', 'checkin_time', 'checkout_date')]
