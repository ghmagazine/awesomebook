import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 下の行から本書スタート
# replace関数によって、Noneをnanに変換
# （Noneを指定する際には文字列として指定する必要がある）
production_miss_num.replace('None', np.nan, inplace=True)

# dropna関数によって、thicknessにnanを含むレコードを削除
production_miss_num.dropna(subset=['thickness'], inplace=True)
