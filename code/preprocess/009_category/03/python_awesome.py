import pandas as pd
import numpy as np
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# pd.Categoricalによって、category型に変換
customer_tb['age_rank'] = \
  pd.Categorical(np.floor(customer_tb['age']/10)*10)

# マスタデータに'60以上'を追加
customer_tb['age_rank'].cat.add_categories(['60以上'], inplace=True)

# 集約するデータを書き換え
# category型は、=または!=の判定のみ可能なので、isin関数を利用
customer_tb.loc[customer_tb['age_rank'] \
           .isin([60.0, 70.0, 80.0]), 'age_rank'] = '60以上'

# 利用されていないマスタデータを削除
customer_tb['age_rank'].cat.remove_unused_categories(inplace=True)
