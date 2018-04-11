import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# to_datetime関数で、datetime64[ns]型に変換
pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')
pd.to_datetime(reserve_tb['checkin_date'] + reserve_tb['checkin_time'],
               format='%Y-%m-%d%H:%M:%S')

# datetime64[ns]型から日付情報を取得
pd.to_datetime(reserve_tb['reserve_datetime'],
               format='%Y-%m-%d %H:%M:%S').dt.date
pd.to_datetime(reserve_tb['checkin_date'], format='%Y-%m-%d').dt.date
