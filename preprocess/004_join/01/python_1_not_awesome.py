from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# reserve_tbとhotel_tbを、hotel_idが等しいもの同士で内部結合
# people_numが1かつis_businessがTrueのデータのみ抽出
pd.merge(reserve_tb, hotel_tb, on='hotel_id', how='inner') \
  .query('people_num == 1 & is_business')
