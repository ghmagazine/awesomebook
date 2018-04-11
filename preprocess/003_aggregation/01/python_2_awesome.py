from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# agg関数を利用して、集約処理をまとめて指定
# reserve_idを対象にcount関数を適用
# customer_idを対象にnunique関数を適用
result = reserve_tb \
  .groupby('hotel_id') \
  .agg({'reserve_id': 'count', 'customer_id': 'nunique'})

# reset_index関数によって、列番号を振り直す（inplace=Trueなので、直接resultを更新）
result.reset_index(inplace=True)
result.columns = ['hotel_id', 'rsv_cnt', 'cus_cnt']
