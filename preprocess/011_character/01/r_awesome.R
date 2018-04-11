source('preprocess/load_data/data_loader.R')
load_meros_txt()
load_txt_df()

# 下記から本書掲載
# MeCabをRで利用するためのライブラリ読み込み
library(RMeCab)

# merosには、メロスの文章データが格納
# MeCabを用いて、形態素解析を実行
words <- RMeCabC(meros)

# 形態素解析の結果のリストをdata.frameに変換
words <- data.frame(part=names(unlist(words)), word=unlist(words))

# 名詞と動詞の単語を抽出
word_list <- words %>% filter(part == '名詞' | part == '動詞') %>% select(word)
