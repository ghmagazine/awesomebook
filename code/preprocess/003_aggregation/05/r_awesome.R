library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# round関数で、total_priceを1000単位で四捨五入
# table関数で、算出した金額別の予約数を算出
# (ベクトルの属性情報(names)が算出した金額、ベクトルの値が予約数)
# which.max関数によって、予約数が最大のベクトル要素を取得
# names関数によって、予約数が最大のベクトル要素の属性情報(names)を取得
names(which.max(table(round(reserve_tb$total_price, -3))))
