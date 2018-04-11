import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 下の行から本書スタート
# replace関数によって、Noneをnanに変換
production_miss_num.replace('None', np.nan, inplace=True)

# thicknessを数値型に変換（Noneが混ざっているため数値型になっていない）
production_miss_num['thickness'] = \
  production_miss_num['thickness'].astype('float64')

# thicknessの平均値を計算
thickness_mean = production_miss_num['thickness'].mean()

# thicknessの欠損値をthicknessの平均値で補完
production_miss_num['thickness'].fillna(thickness_mean, inplace=True)

