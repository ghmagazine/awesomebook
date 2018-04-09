from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# drop関数によって、不要な列を削除
# axisを1にすることによって、列の削除を指定
# inplaceをTrueに指定することによって、reserve_tbの書き換えを指定
reserve_tb.drop(['people_num', 'total_price'], axis=1, inplace=True)
