import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# pivot_table関数で、横持ち変換と集約処理を同時実行
# aggfuncに予約数をカウントする関数を指定
pd.pivot_table(reserve_tb, index='customer_id', columns='people_num',
               values='reserve_id',
               aggfunc=lambda x: len(x), fill_value=0)