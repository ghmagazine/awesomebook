library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production()

# 下記から本書掲載
production_tb %>%
  group_by(type) %>%
  mutate(fault_rate_per_type=(sum(fault_flg) - fault_flg) / (n() - 1))
