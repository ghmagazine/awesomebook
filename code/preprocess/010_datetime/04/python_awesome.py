import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# timedelta用にdatetimeライブラリを読み込み
import datetime

# reserve_datetimeをdatetime64[ns]型に変換
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# reserve_datetimeからdateを抽出
reserve_tb['reserve_date'] = reserve_tb['reserve_datetime'].dt.date

# reserve_datetimeに1日加える
reserve_tb['reserve_datetime'] + datetime.timedelta(days=1)

# reserve_dateに1日加える
reserve_tb['reserve_date'] + datetime.timedelta(days=1)

# reserve_datetimeに1時間加える
reserve_tb['reserve_datetime'] + datetime.timedelta(hours=1)

# reserve_datetimeに1分加える
reserve_tb['reserve_datetime'] + datetime.timedelta(minutes=1)

# reserve_datetimeに1秒加える
reserve_tb['reserve_datetime'] + datetime.timedelta(seconds=1)