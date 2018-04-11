import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# reserve_datetimeをdatetime64[ns]型に変換
reserve_tb['reserve_datetime'] = pd.to_datetime(
  reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S'
)

# 月の数字を季節に変換する関数
def to_season(month_num):
  season = 'winter'
  if 3 <= month_num <= 5:
    season = 'spring'
  elif 6 <= month_num <= 8:
    season = 'summer'
  elif 9 <= month_num <= 11:
    season = 'autumn'
  
  return season

# 季節に変換
reserve_tb['reserve_season'] = pd.Categorical(
  reserve_tb['reserve_datetime'].dt.month.apply(to_season),
  categories=['spring', 'summer', 'autumn', 'winter']
)
