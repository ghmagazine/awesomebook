from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# rank関数で並び替えるために、データ型を文字列からtimestamp型に変換
# （「第10章 日時型」で解説）
reserve_tb['reserve_datetime'] = pd.to_datetime(
  reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S'
)

# log_noを新たな列として追加
# 集約単位の指定はgroup_byを利用
# 顧客ごとにまとめたreserve_datetimeを生成し、rank関数によって順位を生成
# ascendingをTrueにすることで昇順に設定(Falseだと降順に設定)
reserve_tb['log_no'] = reserve_tb \
  .groupby('customer_id')['reserve_datetime'] \
  .rank(ascending=True, method='first')
