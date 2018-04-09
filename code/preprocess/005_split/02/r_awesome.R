library(dplyr)
source('preprocess/load_data/data_loader.R')
load_monthly_index()

# 下記から本書掲載
# createTimeSlices用のライブラリ
library(caret)

# 乱数のシード設定
set.seed(71)

# 年月に基づいてデータを並び替え
target_data <- monthly_index_tb %>% arrange(year_month) %>% as.data.frame()

# createTimeSlices関数によって、学習データと検証データに分割したデータ行番号を取得
# initialWindowに学習データ数を設定
# horizonに検証データ数を設定
# skipにスライドするデータ数-1の値を設定
# fixedWindowをTに指定すると、学習データ数を増やさずにスライド
timeSlice <-
  createTimeSlices(1:nrow(target_data), initialWindow=24, horizon=12,
                   skip=(12 - 1), fixedWindow=TRUE)

# データを分割した数だけfor文で繰り返す
for(slice_no in 1:length(timeSlice$train)){

  # 行番号を指定して、元データから学習データを取得
  train <- target_data[timeSlice$train[[slice_no]], ]

  # 行番号を指定して、元データから検証データを取得
  test <- target_data[timeSlice$test[[slice_no]], ]

  # trainを学習データ、testを検証データとして機械学習モデルの構築、検証
}

# 交差検証の結果をまとめる
