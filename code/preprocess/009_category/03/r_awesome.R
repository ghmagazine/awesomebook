library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
customer_tb$age_rank <- factor(floor(customer_tb$age / 10) * 10)

# マスタデータに'60以上'を追加
levels(customer_tb$age_rank) <- c(levels(customer_tb$age_rank), '60以上')

# 集約するデータを書き換え
# カテゴリ型の場合は、==または!=の判定しかできない
# in関数を利用して、置換を実現
customer_tb[customer_tb$age_rank %in% c('60', '70', '80'), 'age_rank'] <-
  '60以上'

# 利用されていないマスタデータ(60,70,80)を削除
customer_tb$age_rank <- droplevels(customer_tb$age_rank)
