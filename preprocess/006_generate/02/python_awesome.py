from preprocess.load_data.data_loader import load_production
production_tb = load_production()

# 下の行から本書スタート
# SMOTE関数をライブラリから読み込み
from imblearn.over_sampling import SMOTE

# SMOTE関数の設定
# ratioは不均衡データにおける少ない例のデータを多い方のデータの何割まで増やすか設定
# （autoの場合は同じ数まで増やす、0.5と設定すると5割までデータを増やす）
# k_neighborsはsmoteのkパラメータ
# random_stateは乱数のseed（乱数の生成パターンの元）
sm = SMOTE(ratio='auto', k_neighbors=5, random_state=71)

# オーバーサンプリング実行
blance_data, balance_target = \
  sm.fit_sample(production_tb[['length', 'thickness']],
                production_tb['fault_flg'])
