from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# loc関数の2次元配列の1次元目に条件を指定することで、条件に適合した行を抽出
# loc関数の2次元配列の2次元目に:を指定することで、全列を抽出
reserve_tb.loc[(reserve_tb['checkout_date'] >= '2016-10-13') &
               (reserve_tb['checkout_date'] <= '2016-10-14'), :]
