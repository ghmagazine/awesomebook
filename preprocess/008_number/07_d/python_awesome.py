import pandas as pd
import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 下の行から本書スタート
from fancyimpute import MICE

# replace関数によって、Noneをnanに変換
production_miss_num.replace('None', np.nan, inplace=True)

# mice関数を利用するためにデータ型を変換（mice関数内でモデル構築をするため）
production_miss_num['thickness'] = \
  production_miss_num['thickness'].astype('float64')
production_miss_num['type'] = \
  production_miss_num['type'].astype('category')
production_miss_num['fault_flg'] = \
  production_miss_num['fault_flg'].astype('category')

# ダミー変数化（「第9章 カテゴリ型」で詳しく解説)
production_dummy_flg = pd.get_dummies(
  production_miss_num[['type', 'fault_flg']], drop_first=True)

# mice関数にPMMを指定して、多重代入法を実施
# n_imputationsは取得するデータセットの数
# n_burn_inは値を取得する前に試行する回数
mice = MICE(n_imputations=10, n_burn_in=50, impute_type='pmm')

# 処理内部でTensorFlowを利用
production_mice = mice.multiple_imputations(
  # 数値の列とダミー変数を連結
  pd.concat([production_miss_num[['length', 'thickness']],
             production_dummy_flg], axis=1)
)

# 下記に補完する値が格納されている
production_mice[0]
