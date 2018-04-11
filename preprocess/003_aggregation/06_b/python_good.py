from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# 予約回数を計算(「3-1 データ数、種類数の算出」の例題を参照)
rsv_cnt_tb = reserve_tb.groupby('hotel_id').size().reset_index()
rsv_cnt_tb.columns = ['hotel_id', 'rsv_cnt']

# 予約回数をもとに順位を計算
# ascendingをFalseにすることで降順に指定
# methodをminに指定し、同じ値の場合は取り得る最小順位に指定
rsv_cnt_tb['rsv_cnt_rank'] = rsv_cnt_tb['rsv_cnt'] \
  .rank(ascending=False, method='min')

# 必要のないrsv_cntの列を削除
rsv_cnt_tb.drop('rsv_cnt', axis=1, inplace=True)
