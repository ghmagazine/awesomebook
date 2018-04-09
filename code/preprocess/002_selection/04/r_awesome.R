library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# reserve_tbから顧客IDのベクトルを取得し、重複を排除した顧客IDベクトルを作成
all_id <- unique(reserve_tb$customer_id)

reserve_tb %>%

  # sample関数を利用し、ユニークな顧客IDから50%サンプリングし、抽出対象のIDを取得
  # 抽出対象のIDと一致する行のみをfilter関数によって抽出
  filter(customer_id %in% sample(all_id, size=length(all_id) * 0.5))
