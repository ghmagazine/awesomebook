from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# round関数で四捨五入した後に、mode関数で最頻値を算出
reserve_tb['total_price'].round(-3).mode()
