from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# total_priceに対して、var関数とstd関数を適用し、分散値と標準偏差値を算出
result = reserve_tb \
  .groupby('hotel_id') \
  .agg({'total_price': ['var', 'std']}).reset_index()
result.columns = ['hotel_id', 'price_var', 'price_std']

# データ数が1件だったときは、分散値と標準偏差値がnaになっているので、0に置き換え
result.fillna(0, inplace=True)
