import numpy as np
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
reserve_tb['total_price_log'] = \
  reserve_tb['total_price'].apply(lambda x: np.log(x / 1000 + 1))
