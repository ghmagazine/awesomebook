from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
import pandas.tseries.offsets as offsets
import operator

# 日時の計算に利用するため、データ型を文字列から日付型に変換
# (「第10章 日時型」で詳しく解説)
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# reserve_datetimeの日付を確認せずに、同じcustomer_idのデータ行同士をすべて結合
sum_table = pd.merge(
	reserve_tb[['reserve_id', 'customer_id', 'reserve_datetime']],
  reserve_tb[['customer_id', 'reserve_datetime', 'total_price']]
            .rename(columns={'reserve_datetime': 'reserve_datetime_before'}),
  on='customer_id')

# checkinの日付を比較して、90日以内のデータが結合されているデータ行のみ抽出
# operatorのand_関数を利用して、複合条件を設定
# reserve_idごとにtotal_priceの合計値を計算
# (日付のデータ型については、「第10章 日時型」で詳しく解説)
sum_table = sum_table[operator.and_(
  sum_table['reserve_datetime'] > sum_table['reserve_datetime_before'],
  sum_table['reserve_datetime'] + offsets.Day(-90) <= sum_table['reserve_datetime_before']
)].groupby('reserve_id')['total_price'].sum().reset_index()

# 列名を設定
sum_table.columns = ['reserve_id', 'total_price_sum']

# 計算した合計値を結合し、元のテーブルに情報を付与
# 合計値が存在しないレコードの合計値の値を、fillnaを利用して0に変更
pd.merge(reserve_tb, sum_table, on='reserve_id', how='left').fillna(0)
