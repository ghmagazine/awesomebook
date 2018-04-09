from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# iloc関数の2次元配列の1次元目に:を指定することで、全行を抽出
# iloc関数の2次元配列の2次元目に抽出したい行番号の配列を指定することで、列を抽出
# 0:6は、[0, 1, 2, 3, 4, 5]と同様の意味
reserve_tb.iloc[:, 0:6]
