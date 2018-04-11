from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# reserve_tbの配列に文字配列を指定することで、指定した列名の列を抽出
reserve_tb[['reserve_id', 'hotel_id', 'customer_id',
            'reserve_datetime', 'checkin_date', 'checkin_time',
            'checkout_date']]
