from preprocess.load_data.data_loader import load_production
production = load_production()

# 下の行から本書スタート
# 製品種別ごとの障害数
fault_cnt_per_type = production \
  .query('fault_flg') \
  .groupby('type')['fault_flg'] \
  .count()

# 製品種別ごとの製造数
type_cnt = production.groupby('type')['fault_flg'].count()

production['type_fault_rate'] = production[['type', 'fault_flg']] \
  .apply(lambda x:
         (fault_cnt_per_type[x[0]] - int(x[1])) / (type_cnt[x[0]] - 1),
         axis=1)
