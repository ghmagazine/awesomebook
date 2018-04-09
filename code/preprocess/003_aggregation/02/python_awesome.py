from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 集約単位をhotel_idとpeople_numの組み合わせを指定
# 集約したデータからtotal_priceを取り出し、sum関数に適用することで売上合計金額を算出
result = reserve_tb \
  .groupby(['hotel_id', 'people_num'])['total_price'] \
  .sum().reset_index()

# 売上合計金額の列名がtotal_priceになっているので、price_sumに変更
result.rename(columns={'total_price': 'price_sum'}, inplace=True)
