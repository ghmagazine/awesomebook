import pandas as pd
# 下記から本書掲載
import psycopg2
import os
from scipy.sparse import csr_matrix

# psycopg2を利用して、Redshiftとの接続を作成
con = psycopg2.connect(host='IPアドレスまたはホスト名',
                       port=接続ポート番号,
                       dbname='DB名',
                       user='接続ユーザ名',
                       password='接続パスワード')

# 顧客カテゴリマスタをRedshiftから取得
# レコメンド計算後にインデックス番号からIDに変換するために利用
customer_category_mst = \
  pd.read_sql('SELECT * FROM work.customer_category_mst', con)

# ホテルカテゴリマスタをRedshiftから取得
# レコメンド計算後にインデックス番号からIDに変換するために利用
hotel_category_mst = \
  pd.read_sql('SELECT * FROM work.hotel_category_mst', con)

# SQL文をファイルから読み込む
sql_path = os.path.dirname(__file__)+"/03_select_recommendation_data.sql"
with open(sql_path) as f:
  sql = f.read()

# 顧客・ホテルの2016年の宿泊予約数の縦持ちデータをRedshiftから取得
matrix_data = pd.read_sql(sql, con)

# csc_matrixを利用して、スパースマトリックスを作成
recommend_matrix = csr_matrix(
  (matrix_data['rsv_cnt'],
   (matrix_data['customer_category_no'], matrix_data['hotel_category_no'])),
  shape=(customer_category_mst.shape[0], hotel_category_mst.shape[0])
)
