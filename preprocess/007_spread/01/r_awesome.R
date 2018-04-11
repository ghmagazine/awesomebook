library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# 横持ちに変更した際に列名が取得できるようにカテゴリ型(factor)に変更
# カテゴリ型については「第9章 カテゴリ型」で詳しく説明
reserve_tb$people_num <- as.factor(reserve_tb$people_num)

reserve_tb %>%
  group_by(customer_id, people_num) %>%
  summarise(rsv_cnt=n()) %>%

  # spread関数で横持ちに変換
  # fillで該当する値がないときの値を設定
  spread(people_num, rsv_cnt, fill=0)
