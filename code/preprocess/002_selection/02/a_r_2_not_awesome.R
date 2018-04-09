library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# which関数に条件式を指定して、判定結果がTRUEとなる行番号のベクトルを取得
# intersect関数によって、引数の行番号のベクトルに共に出現する行番号のみに絞り込み
# reserve_tbの2次元配列の1次元目に行番号のベクトルを指定し、条件適合する行を抽出
reserve_tb[
  intersect(which(reserve_tb$checkin_date >= '2016-10-12'),
            which(reserve_tb$checkin_date <= '2016-10-13')), ]
