library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# small_area_nameごとにホテル数をカウント、結合キーを判定するためのテーブル
small_area_mst <-
  hotel_tb %>%
    group_by(big_area_name, small_area_name) %>%

    # -1は、自ホテルを引いている
    summarise(hotel_cnt=n() - 1) %>%

    # 集約処理完了後に、グループ化を解除
    ungroup() %>%

    # 20件以上であればjoin_area_idをsmall_area_nameとして設定
    # 20件未満であればjoin_area_idをbig_area_nameとして設定
    mutate(join_area_id=
             if_else(hotel_cnt >= 20, small_area_name, big_area_name)) %>%
    select(small_area_name, join_area_id)

# レコメンド元になるホテルにsmall_area_mstを結合することで、join_area_idを設定
base_hotel_mst <-
  inner_join(hotel_tb, small_area_mst, by='small_area_name') %>%
    select(hotel_id, join_area_id)

# 必要に応じて、メモリを解放(必須ではないがメモリ量に余裕のないときに利用)
rm(small_area_mst)

# recommend_hotel_mstはレコメンド候補のためのテーブル
recommend_hotel_mst <-
  bind_rows(
    # join_area_idをbig_area_nameとしたレコメンド候補マスタ
    hotel_tb %>%
      rename(rec_hotel_id=hotel_id, join_area_id=big_area_name) %>%
      select(join_area_id, rec_hotel_id),

    # join_area_idをsmall_area_nameとしたレコメンド候補マスタ
    hotel_tb %>%
      rename(rec_hotel_id=hotel_id, join_area_id=small_area_name) %>%
      select(join_area_id, rec_hotel_id)
  )

# base_hotel_mstとrecommend_hotel_mstを結合し、レコメンド候補の情報を付与
inner_join(base_hotel_mst, recommend_hotel_mst, by='join_area_id') %>%

  # レコメンド候補から自分を除く
  filter(hotel_id != rec_hotel_id) %>%
  select(hotel_id, rec_hotel_id)
