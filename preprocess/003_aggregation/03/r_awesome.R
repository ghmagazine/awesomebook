library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 下記から本書掲載
reserve_tb %>%
  group_by(hotel_id) %>%

  # quantile関数にtotal_priceと対象の値を指定して20パーセントタイル値を算出
  summarise(price_max=max(total_price),
            price_min=min(total_price),
            price_avg=mean(total_price),
            price_median=median(total_price),
            price_20per=quantile(total_price, 0.2))
