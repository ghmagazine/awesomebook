library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production()

# 下記から本書掲載
# sample.split用のパッケージ
library(caTools)

# cvFolds用のパッケージ
library(cvTools)

# 乱数のシード設定。71はある界隈では幸運を呼ぶと言われている
set.seed(71)

# ホールドアウト検証用のデータ分割
# production_tb$fault_flg、データ行数と同じ長さのベクトルであればなんでも良い
# test_tfは、学習データはFALSE、検証データがTRUEのデータ行数と同じ長さのベクトル
# SplitRatioは検証データの割合
test_tf <- sample.split(production_tb$fault_flg, SplitRatio=0.2)

# production_tbからホールドアウト検証における学習データを抽出
train <- production_tb %>% filter(!test_tf)

# production_tbからホールドアウト検証における検証データを抽出
private_test  <- production_tb %>% filter(test_tf)

# 交差検証用のデータ分割
cv_no <- cvFolds(nrow(train), K=4)

# cv_no$Kで設定した交差数分繰り返し処理（並列処理が可能）
for(test_k in 1:cv_no$K){

  # production_tbから交差検証における学習データを抽出
  train_cv <- train %>% slice(cv_no$subsets[cv_no$which!=test_k])

  # production_tbから交差検証における検証データを抽出
  test_cv <- train %>% slice(cv_no$subsets[cv_no$which==test_k])

  # train_cvを学習データ、test_cvを検証データとして機械学習モデルの構築、検証
}

# 交差検証の結果をまとめる

# trainを学習データ、private_testを検証データとして機械学習モデルの構築、検証
