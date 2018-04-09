from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# 日付型用のライブラリ
import datetime
# 日付の計算用のライブラリ
from dateutil.relativedelta import relativedelta

# 年月マスタの生成
month_mst = pd.DataFrame({
  'year_month':
    # relativedeltaで2017-01-01をx月間進める、xは0,1,2を代入
    # 2017-01-01, 2017-02-01, 2017-03-01のリストを生成
    [(datetime.date(2017, 1, 1) + relativedelta(months=x)).strftime("%Y%m")
     for x in range(0, 3)]
})

# cross joinのためにすべて同じ値の結合キーを準備
customer_tb['join_key'] = 0
month_mst['join_key'] = 0

# customer_tbとmonth_mstを準備した結合キーで内部結合し、全結合を実現
customer_mst = pd.merge(
  customer_tb[['customer_id', 'join_key']], month_mst, on='join_key'
)

# 年月の結合キーを予約テーブルで準備
reserve_tb['year_month'] = reserve_tb['checkin_date'] \
  .apply(lambda x: pd.to_datetime(x, format='%Y-%m-%d').strftime("%Y%m"))

# 予約レコードと結合し、合計利用金額を計算
summary_result = pd.merge(
  customer_mst,
  reserve_tb[['customer_id', 'year_month', 'total_price']],
  on=['customer_id', 'year_month'], how='left'
).groupby(['customer_id', 'year_month'])["total_price"] \
 .sum().reset_index()

# 予約レコードがなかった場合の合計金額を値なしから0に変換
summary_result.fillna(0, inplace=True)
