import pandas as pd
import numpy as np
# ここまでは本書では省略

# 下の行から本書スタート
import psycopg2
import os
import random
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold

# psycopg2を利用して、Redshiftとの接続を作成
con = psycopg2.connect(host='IPアドレスまたはホスト名',
                       port=接続ポート番号,
                       dbname='DB名',
                       user='接続ユーザ名',
                       password='接続パスワード')


# SQL文をファイルから読み込み
with open(os.path.dirname(__file__)+'/01_select_model_data.sql') as f:
  sql = f.read()

# モデリング用のデータをRedshiftから取得
rsv_flg_logs = pd.read_sql(sql, con)

# ダミー変数を作成
rsv_flg_logs['is_man'] = \
  pd.get_dummies(rsv_flg_logs['sex'], drop_first=True)

# 数値の状態でカテゴリを集約してから、カテゴリ型に変換
rsv_flg_logs['age_rank'] = np.floor(rsv_flg_logs['age'] / 10) * 10
rsv_flg_logs.loc[rsv_flg_logs['age_rank'] < 20, 'age_rank'] = 10
rsv_flg_logs.loc[rsv_flg_logs['age_rank'] >= 60, 'age_rank'] = 60

# カテゴリ型に変換
rsv_flg_logs['age_rank'] = rsv_flg_logs['age_rank'].astype('category')

# 年齢のカテゴリ型をダミーフラグに変換して追加
rsv_flg_logs = pd.concat(
  [rsv_flg_logs,
   pd.get_dummies(rsv_flg_logs['age_rank'], drop_first=False)],
  axis=1
)

# 月を12種類のカテゴリ値から数値化
# 過学習の傾向があった場合は最初にこの変数を疑うこと
rsvcnt_m = rsv_flg_logs.groupby('month_num')['rsv_flg'].sum()
cuscnt_m = rsv_flg_logs.groupby('month_num')['customer_id'].count()
rsv_flg_logs['month_num_flg_rate'] =\
  rsv_flg_logs[['month_num', 'rsv_flg']].apply(
    lambda x: (rsvcnt_m[x[0]] - x[1]) / (cuscnt_m[x[0]] - 1), axis=1)

# 過去1年間の予約金額の合計を対数化
# 金額が大きくなるほど、金額の絶対的な大きさの意味は小さくなると予測できるため
rsv_flg_logs['before_total_price_log'] = \
  rsv_flg_logs['before_total_price'].apply(lambda x: np.log(x / 10000 + 1))

# 学習データと検証データに分割

# モデルに利用する変数名を設定
target_log = rsv_flg_logs[['rsv_flg']]
# 必要なくなった変数を削除
rsv_flg_logs.drop(['customer_id', 'rsv_flg', 'sex', 'age', 'age_rank',
                   'month_num', 'before_total_price'], axis=1, inplace=True)

# ホールドアウト検証のために、学習データと検証データを分割
train_data, test_data, train_target, test_target =\
  train_test_split(rsv_flg_logs, target_log, test_size=0.2)

# インデックス番号をリセット
train_data.reset_index(inplace=True, drop=True)
test_data.reset_index(inplace=True, drop=True)
train_target.reset_index(inplace=True, drop=True)
test_target.reset_index(inplace=True, drop=True)

# 交差検定用にデータを分割
row_no_list = list(range(len(train_target)))
random.shuffle(row_no_list)
k_fold = KFold(n_splits=4)

# 交差数分繰り返し
for train_cv_no, test_cv_no in k_fold.split(row_no_list):
  train_data_cv = train_data.iloc[train_cv_no, :]
  train_target_cv = train_target.iloc[train_cv_no, :]
  test_data_cv = train_data.iloc[test_cv_no, :]
  test_target_cv = train_target.iloc[test_cv_no, :]

  # 交差検定のモデリング
  # 学習データ： train_data_cv, train_target_cv
  # テストデータ： test_data_cv, test_target_cv

# ホールドアウト検証のモデリング
# 学習データ： train_data, train_target
# テストデータ： test_data, test_target
