library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# sparseMatrix用のパッケージ
library(Matrix)

cnt_tb <-
  reserve_tb %>%
    group_by(customer_id, people_num) %>%
    summarise(rsv_cnt=n())

# sparseMatrixの行／列に該当する列の値をカテゴリ型（factor）に変換
# 「第9章 カテゴリ型」で詳しく説明
cnt_tb$customer_id <- as.factor(cnt_tb$customer_id)
cnt_tb$people_num <- as.factor(cnt_tb$people_num)

# スパースマトリックスを生成
# 1つ目から3つ目の引数には、横持ちのデータを指定
# 1つ目:行番号、2つ目:列番号、3つ目:指定した行列に対応した値、ベクトルを指定
# dimsには、スパースマトリックスのサイズを指定（行数／列数のベクトルを指定）
# （as.numeric(cnt_tb$customer_id)はインデックス番号の取得）
# （length(levels(cnt_tb$customer_id))は、customer_idのユニークな数を取得）
sparseMatrix(as.numeric(cnt_tb$customer_id), as.numeric(cnt_tb$people_num),
             x=cnt_tb$rsv_cnt,
             dims=c(length(levels(cnt_tb$customer_id)),
                    length(levels(cnt_tb$people_num))))
