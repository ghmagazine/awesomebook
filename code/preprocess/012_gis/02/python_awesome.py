import pandas as pd
import pyproj
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()


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


# 下の行から本書スタート
# pythonで経度緯度の位置情報を扱うライブラリ読み込み
import math
import pyproj

# 距離を計算するためのライブラリ読み込み
from geopy.distance import great_circle, vincenty

# ・・・日本測地形に修正するまでのコード省略・・・

# 予約テーブルに顧客テーブルとホテルテーブルを結合
reserve_tb = \
  pd.merge(reserve_tb, customer_tb, on='customer_id', how='inner')
reserve_tb = pd.merge(reserve_tb, hotel_tb, on='hotel_id', how='inner')

# 家とホテルの経度緯度の情報を取得
home_and_hotel_points = reserve_tb \
  .loc[:, ['home_longitude', 'home_latitude',
           'hotel_longitude', 'hotel_latitude']]

# 赤道半径をWGS84準拠で設定
g = pyproj.Geod(ellps='WGS84')

# 方位角、反方位角、Vincentyの式による距離の計算
home_to_hotel = home_and_hotel_points \
  .apply(lambda x: g.inv(x[0], x[1], x[2], x[3]), axis=1)

# 方位角を取得
[x[0] for x in home_to_hotel]

# Vincentyの式による距離を取得
[x[2] for x in home_to_hotel]

# Haversineの式による距離計算
home_and_hotel_points.apply(
  lambda x: great_circle((x[1], x[0]), (x[3], x[2])).meters, axis=1)

# Vincentyの式による距離計算
home_and_hotel_points.apply(
  lambda x: vincenty((x[1], x[0]), (x[3], x[2])).meters, axis=1)


# Hubenyの式の関数定義
def hubeny(lon1, lat1, lon2, lat2, a=6378137, b=6356752.314245):
    e2 = (a ** 2 - b ** 2) / a ** 2
    (lon1, lat1, lon2, lat2) = \
      [x * (2 * math.pi) / 360 for x in (lon1, lat1, lon2, lat2)]
    w = 1 - e2 * math.sin((lat1 + lat2) / 2) ** 2
    c2 = math.cos((lat1 + lat2) / 2) ** 2
    return math.sqrt((b ** 2 / w ** 3) * (lat1 - lat2) ** 2 +
                     (a ** 2 / w) * c2 * (lon1 - lon2) ** 2)

# Hubenyの式による距離計算
home_and_hotel_points \
  .apply(lambda x: hubeny(x[0], x[1], x[2], x[3]), axis=1)
