library(dplyr)
source('preprocess/load_data/data_loader.R')
load_meros_txt()

# 下記から本書掲載
library(RMeCab)

word_matrix <-
  docDF('data/txt', pos=c('動詞', '名詞'), type=1, weight='tf*idf*norm')
