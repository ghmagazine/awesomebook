library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production_missing_category()

# 下記から本書掲載
# knn関数のためのライブラリを読み込み
library(class)

# typeをfactorに変換
production_missc_tb$type <- factor(production_missc_tb$type)

# 欠損していないデータの抽出
train <- production_missc_tb %>% filter(type != '')

# 欠損しているデータの抽出
test <- production_missc_tb %>% filter(type == '')

# knnによってtype値を補完
# kはknnのパラメータ、probをFALSEにし出力を補完値に設定
test$type <- knn(train=train %>% select(length, thickness),
                 test=test %>% select(length, thickness),
                 cl=factor(train$type), k=3, prob=FALSE)
