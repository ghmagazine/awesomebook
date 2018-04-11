library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# scale関数によって、引数の列値を正規化
# center引数をTRUEにすると変換結果の平均値が0になる
# scale引数をTRUEにすると変換結果の分散値が1になる
reserve_tb %>%
  mutate(
    people_num_normalized=scale(people_num, center=TRUE, scale=TRUE),
    total_price_normalized=scale(total_price, center=TRUE, scale=TRUE)
  )
