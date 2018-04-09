from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# reserve_tbに新たな列としてprice_avgを追加
reserve_tb['price_avg'] = pd.Series(
  reserve_tb

    # データ行をcustomer_idごとにグループ化
    .groupby('customer_id')

    # customer_idごとにreserve_datetimeでデータを並び替え
    .apply(lambda x: x.sort_values(by='reserve_datetime', ascending=True))

    # total_priceのwindow3件にまとめ、その平均値を計算
    # min_periodsを1に設定し、1件以上あった場合には計算するよう設定
    ['total_price'].rolling(center=False, window=3, min_periods=1).mean()

    # group化を解除すると同時に、customer_idの列を削除
    .reset_index(drop=True)
)

# customer_idごとにprice_avgを1行下にずらす
reserve_tb['price_avg'] = \
  reserve_tb.groupby('customer_id')['price_avg'].shift(periods=1)
