import numpy as np
from preprocess.load_data.data_loader import load_production_missing_category
production_missc_tb = load_production_missing_category()

# 下の行から本書スタート
# KNeighborsClassifierをsklearnライブラリから読み込み
from sklearn.neighbors import KNeighborsClassifier

# replace関数によって、Noneをnanに変換
production_missc_tb.replace('None', np.nan, inplace=True)

# 欠損していないデータの抽出
train = production_missc_tb.dropna(subset=['type'], inplace=False)

# 欠損しているデータの抽出
test = production_missc_tb \
  .loc[production_missc_tb.index.difference(train.index), :]

# knnモデル生成、n_neighborsはknnのkパラメータ
kn = KNeighborsClassifier(n_neighbors=3)

# knnモデル学習
kn.fit(train[['length', 'thickness']], train['type'])

# knnモデルによって予測値を計算し、typeを補完
test['type'] = kn.predict(test[['length', 'thickness']])
