library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
# dummyVars関数のためのライブラリ
library(caret)

# ダミー変数化する変数を引数で指定
# fullRankをFALSEにするとすべてのカテゴリ値をフラグ化
dummy_model <- dummyVars(~sex, data=customer_tb, fullRank=FALSE)

# predictでダミー変数を生成
dummy_vars <- predict(dummy_model, customer_tb)
