from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# loc関数の2次元配列の2次元目に抽出したい列名の配列を指定することで、列を抽出
reserve_tb.loc[:, ['reserve_id', 'hotel_id', 'customer_id',
                   'reserve_datetime', 'checkin_date',
                   'checkin_time', 'checkout_date']]
