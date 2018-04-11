from preprocess.load_data.data_loader import load_production
production_tb = load_production()

# 下の行から本書スタート
# PCA読み込み
from sklearn.decomposition import PCA

# n_componentsに、主成分分析で変換後の次元数を設定
pca = PCA(n_components=2)

# 主成分分析を実行
# pcaに主成分分析の変換パラメータが保存され、返り値に主成分分析後の値が返される
pca_values = pca.fit_transform(production_tb[['length', 'thickness']])

# 累積寄与率と寄与率の確認
print('累積寄与率: {0}'.format(sum(pca.explained_variance_ratio_)))
print('各次元の寄与率: {0}'.format(pca.explained_variance_ratio_))

# predict関数を利用し、同じ次元圧縮処理を実行
pca_newvalues = pca.transform(production_tb[['length', 'thickness']])
