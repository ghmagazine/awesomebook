library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# Spatialオブジェクトを扱うためにspパッケージを読み込み
library(sp)

# 対象の顧客テーブルの家の緯度、経度を取得
home_locations <- customer_tb %>% select(home_longitude, home_latitude)

# 分・秒を度に変換する関数を定義
convert_to_continuous <- function(x){
  x_min <- (x * 100 - as.integer(x * 100)) * 100
  x_sec <- (x - as.integer(x) - x_min / 10000) * 100
  return(as.integer(x) + x_sec / 60 + x_min / 60 / 60)
}

# 分・秒を度に変換
home_locations['home_longitude'] <-
  sapply(home_locations['home_longitude'], convert_to_continuous)
home_locations['home_latitude'] <-
  sapply(home_locations['home_latitude'], convert_to_continuous)

# Spatialオブジェクト（経度緯度のセットのデータ型）に変換
coordinates(home_locations) <- c('home_longitude', 'home_latitude')

# 日本測地系の設定
# 文章を分割して、pasete0関数でつないでいるのは書面の関係
proj4string(home_locations) <-CRS(
  paste0('+proj=longlat +ellps=bessel ',
         '+towgs84=-146.336,506.832,680.254,0,0,0,0 +no_defs')
)

# 世界測地系（WGS84）へ変換
# rgdalパッケージをspTransform関数内部で利用
home_locations <-
  spTransform(home_locations,
              CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))

# data.frameに変換
home_locations <- data.frame(home_locations)

# customer_tbの経度緯度を世界測地系に更新
customer_tb$home_longitude <- home_locations$home_longitude
customer_tb$home_latitude <- home_locations$home_latitude


# 下記から本書掲載
library(geosphere)

# ・・・日本測地形に修正するまでのコード省略・・・

# 予約テーブルに顧客テーブルとホテルテーブルを結合
reserve_all_tb <- inner_join(reserve_tb, hotel_tb, by='hotel_id')
reserve_all_tb <- inner_join(reserve_all_tb, customer_tb, by='customer_id')

# 方位角の計算
bearing(reserve_all_tb[, c('home_longitude', 'home_latitude')],
        reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# Haversineの式による距離計算
distHaversine(reserve_all_tb[, c('home_longitude', 'home_latitude')],
              reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# Vincentyの式による距離計算
distVincentySphere(reserve_all_tb[, c('home_longitude', 'home_latitude')],
                   reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# Hubenyの式の関数定義
distHubeny <- function(x){
  a=6378137
  b=6356752.314245
  e2 <- (a ** 2 - b ** 2) / a ** 2
  points <- sapply(x, function(x){return(x * (2 * pi) / 360)})
  lon1 <- points[[1]]
  lat1 <- points[[2]]
  lon2 <- points[[3]]
  lat2 <- points[[4]]
  w = 1 - e2 * sin((lat1 + lat2) / 2) ** 2
  c2 = cos((lat1 + lat2) / 2) ** 2
  return(sqrt((b ** 2 / w ** 3) * (lat1 - lat2) ** 2
              + (a ** 2 / w) * c2 * (lon1 - lon2) ** 2))
}

# Hubenyの式による距離計算
apply(
  reserve_all_tb[, c('home_longitude', 'home_latitude',
                     'hotel_longitude', 'hotel_latitude')],
  distHubeny, MARGIN=1
)

