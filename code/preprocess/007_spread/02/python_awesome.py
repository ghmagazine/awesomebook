import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# スパースマトリックスのライブラリを読み込み
from scipy.sparse import csc_matrix

# 顧客ID／宿泊人数別の予約数の表を生成
cnt_tb = reserve_tb \
  .groupby(['customer_id', 'people_num'])['reserve_id'].size() \
  .reset_index()
cnt_tb.columns = ['customer_id', 'people_num', 'rsv_cnt']

# sparseMatrixの行／列に該当する列の値をカテゴリ型に変換
# カテゴリ型については「第9章 カテゴリ型」で詳しく説明
customer_id = pd.Categorical(cnt_tb['customer_id'])
people_num = pd.Categorical(cnt_tb['people_num'])

# スパースマトリックスを生成
# 1の引数は、指定した行列に対応した値、行番号、列番号の配列をまとめたタプルを指定
# shapeには、スパースマトリックスのサイズを指定（行数／列数のタプルを指定）
# （customer_id.codesはインデックス番号の取得）
# （len(customer_id.categories)は、customer_idのユニークな数を取得）
csc_matrix((cnt_tb['rsv_cnt'], (customer_id.codes, people_num.codes)),
           shape=(len(customer_id.categories), len(people_num.categories)))
