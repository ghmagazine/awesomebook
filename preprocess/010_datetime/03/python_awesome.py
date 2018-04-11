import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# reserve_datetimeをdatetime64[ns]型に変換
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# checkin_datetimeをdatetime64[ns]型に変換
reserve_tb['checkin_datetime'] = \
  pd.to_datetime(reserve_tb['checkin_date'] + reserve_tb['checkin_time'],
                 format='%Y-%m-%d%H:%M:%S')

# 年の差分を計算（月以下の日時要素は考慮しない）
reserve_tb['reserve_datetime'].dt.year - \
reserve_tb['checkin_datetime'].dt.year

# 月の差分を取得（日以下の日時要素は考慮しない）
(reserve_tb['reserve_datetime'].dt.year * 12 +
 reserve_tb['reserve_datetime'].dt.month) \
 - (reserve_tb['checkin_datetime'].dt.year * 12 +
    reserve_tb['checkin_datetime'].dt.month)

# 日単位で差分を計算
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[D]')

# 時単位で差分を計算
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[h]')

# 分単位で差分を計算
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[m]')

# 秒単位で差分を計算
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[s]')
