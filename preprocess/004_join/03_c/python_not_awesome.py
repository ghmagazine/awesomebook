from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# customer_idごとにreserve_datetimeでデータを並び替え
result = reserve_tb.groupby('customer_id') \
  .apply(lambda x: x.sort_values(by='reserve_datetime', ascending=True)) \
  .reset_index(drop=True)

# 新たな列としてprice_avgを追加
result['price_avg'] = pd.Series(
  result
    # customer_idごとにtotal_priceのwindow3件にまとめ、その平均値を計算
    # min_periodsを1に設定し、1件以上あった場合には計算するよう設定
    .groupby('customer_id')
    ['total_price'].rolling(center=False, window=3, min_periods=1).mean()

    # group化を解除すると同時に、customer_idの列を削除
    .reset_index(drop=True)
)

# customer_idごとにprice_avgを1行下にずらす
result['price_avg'] = \
  result.groupby('customer_id')['price_avg'].shift(periods=1)
