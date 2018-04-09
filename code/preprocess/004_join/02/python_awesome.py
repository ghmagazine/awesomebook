from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
import numpy as np
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# ガベージコレクション(必要ないメモリの解放)のためのライブラリ
import gc

# small_area_nameごとにホテル数をカウント
small_area_mst = hotel_tb \
  .groupby(['big_area_name', 'small_area_name'], as_index=False) \
  .size().reset_index()
small_area_mst.columns = ['big_area_name', 'small_area_name', 'hotel_cnt']

# 20件以上であればjoin_area_idをsmall_area_nameとして設定
# 20件未満であればjoin_area_idをbig_area_nameとして設定
# -1は、自ホテルを引いている
small_area_mst['join_area_id'] = \
  np.where(small_area_mst['hotel_cnt'] - 1 >= 20,
           small_area_mst['small_area_name'],
           small_area_mst['big_area_name'])

# 必要なくなった列を削除
small_area_mst.drop(['hotel_cnt', 'big_area_name'], axis=1, inplace=True)

# レコメンド元になるホテルにsmall_area_mstを結合することで、join_area_idを設定
base_hotel_mst = pd.merge(hotel_tb, small_area_mst, on='small_area_name') \
                   .loc[:, ['hotel_id', 'join_area_id']]

# 下記は必要に応じて、メモリを解放(必須ではないですがメモリ量に余裕のないときに利用)
del small_area_mst
gc.collect()

# recommend_hotel_mstはレコメンド候補のためのテーブル
recommend_hotel_mst = pd.concat([
  # join_area_idをbig_area_nameとしたレコメンド候補マスタ
  hotel_tb[['small_area_name', 'hotel_id']] \
    .rename(columns={'small_area_name': 'join_area_id'}, inplace=False),

  # join_area_idをsmall_area_nameとしたレコメンド候補マスタ
  hotel_tb[['big_area_name', 'hotel_id']] \
    .rename(columns={'big_area_name': 'join_area_id'}, inplace=False)
])

# hotel_idの列名が結合すると重複するので変更
recommend_hotel_mst.rename(columns={'hotel_id': 'rec_hotel_id'}, inplace=True)

# base_hotel_mstとrecommend_hotel_mstを結合し、レコメンド候補の情報を付与
# query関数によってレコメンド候補から自分を除く
pd.merge(base_hotel_mst, recommend_hotel_mst, on='join_area_id') \
  .loc[:, ['hotel_id', 'rec_hotel_id']] \
  .query('hotel_id != rec_hotel_id')
