from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# customerごとにreserve_datetimeで並び替え
# groupby関数のあとにapply関数を適用することによって、groupごとに並び替える
# sort_values関数によってデータを並び替え、axisが0の場合は行、1の場合は列を並び替え
result = reserve_tb \
  .groupby('customer_id') \
  .apply(lambda group:
         group.sort_values(by='reserve_datetime', axis=0, inplace=False))

# resultはすでに、customer_idごとにgroup化されている
# customerごとに2つ前のtotal_priceをbefore_priceとして保存
# shift関数は、periodsの引数の数だけデータ行を下にずらす関数
result['before_price'] = \
  pd.Series(result['total_price'].shift(periods=2))
