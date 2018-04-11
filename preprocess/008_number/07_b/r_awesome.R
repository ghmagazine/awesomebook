library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 下記から本書掲載
production_missn_tb %>%

  # replace_na関数によって、thicknessがNULL/NA/NaNのときに1で補完
  replace_na(list(thickness = 1))
