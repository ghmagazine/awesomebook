library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
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
# 誌面の関係上、文章を分割してpasete0関数でつなぐ
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
