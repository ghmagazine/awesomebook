from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# groupby関数でreserve_idを集約単位に指定し、size関数でデータ数をカウント
# groupby関数の集約処理によって行番号（index）がとびとびになっているので、
# reset_index関数によって、集約単位に指定したhotel_idを集約した状態から列名に戻し、
# 新たな行名を現在の行番号を直す
rsv_cnt_tb = reserve_tb.groupby('hotel_id').size().reset_index()

# 集約結果の列名を設定
rsv_cnt_tb.columns = ['hotel_id', 'rsv_cnt']

# groupbyでhotel_idを集約単位に指定し、
# customer_idの値をnunique関数することで顧客数をカウント
cus_cnt_tb = \
  reserve_tb.groupby('hotel_id')['customer_id'].nunique().reset_index()

# 集約結果の列名を設定
cus_cnt_tb.columns = ['hotel_id', 'cus_cnt']

# merge関数を用いて、hotel_idを結合キーとして結合(「第4章 結合」で解説)
pd.merge(rsv_cnt_tb, cus_cnt_tb, on='hotel_id')
