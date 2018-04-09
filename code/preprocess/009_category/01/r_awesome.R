library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# sexがmanのときにTRUEとするブール型を追加
# このコードは、as.logical関数がなくてもブール型に変換される
customer_tb$sex_is_man <- as.logical(customer_tb$sex == 'man')

# sexをカテゴリ型に変換
customer_tb$sex_c <- factor(customer_tb$sex, levels=c('man', 'woman'))

# 数値に変換するとインデックスデータの数値が取得できる
as.numeric(customer_tb$sex_c)

# levels関数を使うとマスターデータにアクセスできる
levels(customer_tb$sex_c)
