from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# reserve_tb['customer_id'].unique()は、重複を排除したcustomer_idを返す
# sample関数を利用するためにpandas.Series(pandasのリストオブジェクト)に変換
# sample関数によって、顧客IDをサンプリング
target = pd.Series(reserve_tb['customer_id'].unique()).sample(frac=0.5)

# isin関数によって、customer_idがサンプリングした顧客IDのいずれかに一致した行を抽出
reserve_tb[reserve_tb['customer_id'].isin(target)]
