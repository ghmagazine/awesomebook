from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
import pyproj


# 分・秒を度に変換する関数を定義
def convert_to_continuous(x):
  # 下記の式で実行すると丸め誤差が発生
  # 正確な値を計算したい場合は、文字列にしてから桁数を見て度・分・秒の数字を抽出
  x_min = (x * 100 - int(x * 100)) * 100
  x_sec = (x - int(x) - x_min / 10000) * 100
  return int(x) + x_sec / 60 + x_min / 60 / 60

# 分・秒を度に変換
customer_tb['home_latitude'] = customer_tb['home_latitude'] \
  .apply(lambda x: convert_to_continuous(x))
customer_tb['home_longitude'] = customer_tb['home_longitude'] \
  .apply(lambda x: convert_to_continuous(x))

# 世界測地系（EPSGコード4326は、WGS84と同等）の取得
epsg_world = pyproj.Proj('+init=EPSG:4326')

# 日本測地系の取得
epsg_japan = pyproj.Proj('+init=EPSG:4301')

# 日本測地系を世界測地系への変換
home_position = customer_tb[['home_longitude', 'home_latitude']] \
  .apply(lambda x:
         pyproj.transform(epsg_japan, epsg_world, x[0], x[1]), axis=1)

# customer_tbの経度緯度を世界測地系に更新
customer_tb['home_longitude'] = [x[0] for x in home_position]
customer_tb['home_latitude'] = [x[1] for x in home_position]
