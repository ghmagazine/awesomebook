import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# ダミー変数化する前にカテゴリ型に変換
customer_tb['sex'] = pd.Categorical(customer_tb['sex'])

# get_dummies関数によってsexをダミー変数化
# drop_firstをFalseにすると、カテゴリ値の全種類の値のダミーフラグを生成
dummy_vars = pd.get_dummies(customer_tb['sex'], drop_first=False)
