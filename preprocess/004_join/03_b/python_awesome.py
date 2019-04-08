from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# customer_idごとにreserve_datetimeでデータを並び替え
result = reserve_tb.groupby('customer_id') \
  .apply(lambda x: x.sort_values(by='reserve_datetime', ascending=True)) \
  .reset_index(drop=True)

# 新たな列としてprice_sumを追加
result['price_sum'] = pd.Series(
    # 必要なデータ列のみに絞り込み
    result.loc[:, ["customer_id", "total_price"]]

    # customer_idごとにtotal_priceのwindow3件にまとめ、その合計値を計算
    .groupby('customer_id')
    .rolling(center=False, window=3, min_periods=3).sum()

    # group化を解除すると同時に、total_priceの列を取り出し
    .reset_index(drop=True)
    .loc[:, 'total_price']
)
