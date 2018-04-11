import pandas as pd
import numpy as np
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
customer_tb['sex_and_age'] = pd.Categorical(
  # 連結する列を抽出
  customer_tb[['sex', 'age']]

    # lambda関数内でsexと10代区切りのageを_を挟んで文字列として連結
    .apply(lambda x: '{}_{}'.format(x[0], np.floor(x[1] / 10) * 10),
           axis=1)
)
