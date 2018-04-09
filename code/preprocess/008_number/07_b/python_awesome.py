import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 下の行から本書スタート
# replace関数によって、Noneをnanに変換
production_miss_num.replace('None', np.nan, inplace=True)

# fillna関数によって、thicknessの欠損値を1で補完
production_miss_num['thickness'].fillna(1, inplace=True)
