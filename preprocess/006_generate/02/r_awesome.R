source('preprocess/load_data/data_loader.R')
load_production()

# 下記から本書掲載
library(tidyverse)

# ubBalance用のライブラリ
library(unbalanced)

# 不均衡の多いデータ数が927,少ないデータ数が73のときのpercOverの設定値の計算式
percOver <- round(927 / 73) * 100 - 100

# 不均衡を正す対象をfactor型に変換(logical型ではないことに注意)
# （第9章「9-1 カテゴリ型」の例題で解説）
production_tb$fault_flg <- as.factor(production_tb$fault_flg)

# ubBalance関数でオーバーサンプリングを実現
# typeにubSMOTEを設定
# positiveは分類で少ない方の値を指定（指定しないことも可能だが警告が表示される）
# percOverは、元データから何％増やすかを設定
# （200なら3(200/100+1)倍、500なら6(500/100+1)倍となる。100未満の値は切り捨て）
# percUnderはアンダーサンプリングを行うときに必要だが、行わない場合は0で設定
# kはsmoteのkパラメータ
production_balance <-
  ubBalance(production_tb[,c('length', 'thickness')],
            production_tb$fault_flg,
            type='ubSMOTE', positive='TRUE',
            percOver=percOver, percUnder=0, k=5)

# 生成したfault_flgがTRUEのデータと元のfault_flgがFALSEのデータを合わせる
bind_rows(

  # production_balance$Xに生成したlengthとthicknessのdata.frameが格納
  production_balance$X %>%

    # production_balance$Yに生成したfault_flgのベクトルが格納
    mutate(fault_flg=production_balance$Y),

  # 元のfault_flgがFalseデータの取得
  production_tb %>%

    # factor型なので一致判定で取得
    filter(fault_flg == 'FALSE') %>%
    select(length, thickness, fault_flg)
)
