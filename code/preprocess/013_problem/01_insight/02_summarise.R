library(dplyr)
# ここまでは本書では省略

# 下の行から本書スタート
library(tidyr)
library(RPostgreSQL)

# 分析対象データをSQLで取り出す
con <- dbConnect(dbDriver('PostgreSQL'),
                 host='IPアドレスまたはホスト名',
                 port='接続ポート番号',
                 dbname='DB名',
                 user='接続ユーザ名',
                 password='接続パスワード')
sql <- paste(readLines('01_select_base_log.sql'), collapse='\n')
base_log <- dbGetQuery(con,sql)

# 年代のカテゴリを作成する
base_log$age_rank <- as.factor(floor(base_log$age/10)*10)
levels(base_log$age_rank) <- c(levels(base_log$age_rank),'60以上')
base_log[base_log$age_rank %in% c('60', '70', '80'), 'age_rank'] <- '60以上'
base_log$age_rank <- droplevels(base_log$age_rank)

# 年代、性別で傾向を把握する
age_sex_summary <- 
  base_log %>%
    group_by(age_rank, sex) %>%
    summarise(customer_cnt=n_distinct(customer_id),
              rsv_cnt=n(),
              people_num_avg=mean(people_num),
              price_per_person_avg=mean(total_price/people_num)
    )

# 各指標ごとに、性別を横持ちに展開
age_sex_summary %>%
  select(age_rank, sex, customer_cnt) %>% 
  spread(age_rank, customer_cnt)

age_sex_summary %>%
  select(age_rank, sex, rsv_cnt) %>% 
  spread(age_rank, rsv_cnt)

age_sex_summary %>%
  select(age_rank, sex, people_num_avg) %>% 
  spread(age_rank, people_num_avg)

age_sex_summary %>%
  select(age_rank, sex, price_per_person_avg) %>% 
  spread(age_rank, price_per_person_avg)