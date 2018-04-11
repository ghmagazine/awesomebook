library(mice)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 下記から本書掲載
library(mice)

# mice関数を利用するためにデータ型を変換（mice関数内でモデル構築をするため）
production_missn_tb$type <- as.factor(production_missn_tb$type)

# fault_flgが文字列の状態なのでブール型に変換（「第9章 カテゴリ型で解説）
production_missn_tb$fault_flg <- production_missn_tb$fault_flg == 'TRUE'

# mice関数にpmmを指定して、多重代入法を実施
# mは、取得するデータセットの数
# maxitは値を取得する前に試行する回数
production_mice <-
  mice(production_missn_tb, m=10, maxit=50, method='pmm', seed=71)

# 下記に補完する値が格納されている
production_mice$imp$thickness
