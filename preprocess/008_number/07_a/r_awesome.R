library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 下記から本書掲載
# drop_na関数によって、thicknessがNULL/NA/NaNであるレコードを削除
production_missn_tb %>% drop_na(thickness)

# すべての列のいずれかにNULL, NA, NaNを含むすべてのレコードを削除
# na.omit(production_missn_tb)
