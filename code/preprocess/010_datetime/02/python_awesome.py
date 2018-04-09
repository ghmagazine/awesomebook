import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# reserve_datetimeをdatetime64[ns]型に変換
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# 年を取得
reserve_tb['reserve_datetime'].dt.year

# 月を取得
reserve_tb['reserve_datetime'].dt.month

# 日を取得
reserve_tb['reserve_datetime'].dt.day

# 曜日（0=日曜日、1＝月曜日）を数値で取得
reserve_tb['reserve_datetime'].dt.dayofweek

# 時刻の時を取得
reserve_tb['reserve_datetime'].dt.hour

# 時刻の分を取得
reserve_tb['reserve_datetime'].dt.minute

# 時刻の秒を取得
reserve_tb['reserve_datetime'].dt.second

# 指定したフォーマットの文字列に変換
reserve_tb['reserve_datetime'].dt.strftime('%Y-%m-%d %H:%M:%S')