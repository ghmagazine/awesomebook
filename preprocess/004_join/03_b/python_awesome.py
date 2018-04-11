from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# 予約テーブルにprice_avgを追加
reserve_tb['price_sum'] = pd.Series(
  reserve_tb

    # データ行をcustomer_idごとにグループ化
    .groupby('customer_id')

    # customer_idごとにreserve_datetimeでデータを並び替え
    .apply(lambda x: x.sort_values(by='reserve_datetime', ascending=True))

    # total_priceのwindow3件にまとめ、その合計値を計算
    .loc[:, 'total_price']
    .rolling(center=False, window=3, min_periods=3).sum()

    # group化を解除すると同時に、customer_idの列を削除
    .reset_index(drop=True)
)

