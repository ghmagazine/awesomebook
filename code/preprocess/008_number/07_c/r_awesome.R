library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 下記から本書掲載
# 欠損値を除き、thicknessの平均値を計算
# na.rmをTRUEにすることでNAを除いた集約値を計算可能
thickness_mean <- mean(production_missn_tb$thickness, na.rm=TRUE)

# replace_na関数によって、欠損値を除いたthicknessの平均値で補完
production_missn_tb %>% replace_na(list(thickness = thickness_mean))
