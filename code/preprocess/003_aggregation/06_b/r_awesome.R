library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%

  # ホテルごとの予約回数の計算のために、hotel_idを集約単位に指定
  group_by(hotel_id) %>%

  # データの件数を計算し、ホテルごとの予約回数を計算
  summarise(rsv_cnt=n()) %>%

  # 予約回数をもとに順位を計算、desc関数を利用することで降順に変更
  # transmute関数によって、rsv_cnt_rankを生成し、
  # 必要なhotel_idとrsv_cnt_rankのみ抽出
  transmute(hotel_id, rsv_cnt_rank=min_rank(desc(rsv_cnt)))
