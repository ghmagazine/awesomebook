library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# checkin_dateの条件式によって、判定結果のTRUE/FALSEのベクトルを取得
# 条件式を&でつなぐことによって、判定結果がともにTRUEの場合のみTRUEとなるベクトルを取得
# reserve_tbの2次元配列の1次元目にTRUE/FALSEのベクトルを指定し、条件適合する行を抽出
# reserve_tbの2次元配列の2次元目を空にすることで、すべての列を抽出
reserve_tb[reserve_tb$checkin_date >= '2016-10-12' &
           reserve_tb$checkin_date <= '2016-10-13', ]
