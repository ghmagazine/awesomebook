from preprocess.load_data.data_loader import load_hotel_reserve
import numpy as np
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# total_priceを対象にmax/min/mean/median関数を適用
# Pythonのラムダ式をagg関数の集約処理に指定
# ラムダ式にはnumpy.percentileを指定しパーセントタイル値を算出（パーセントは20指定）
result = reserve_tb \
  .groupby('hotel_id') \
  .agg({'total_price': ['max', 'min', 'mean', 'median',
                        lambda x: np.percentile(x, q=20)]}) \
  .reset_index()
result.columns = ['hotel_id', 'price_max', 'price_min', 'price_mean',
                  'price_median', 'price_20per']
