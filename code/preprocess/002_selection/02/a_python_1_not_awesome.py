from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# 配列に条件式を指定することで、条件に適合した行を抽出
# DataFrameの特定の列に対する不等式によって、判定結果のTrue/Falseの配列を取得
# 条件式を&で繋ぐことによって、判定結果が共にTrueの場合のみTrueとなる配列を取得
reserve_tb[(reserve_tb['checkout_date'] >= '2016-10-13') &
           (reserve_tb['checkout_date'] <= '2016-10-14')]
