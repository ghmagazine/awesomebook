from preprocess.load_data.data_loader import load_production
production_tb = load_production()

# 下の行から本書スタート
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold

# ホールドアウト検証用のデータ分割
# 予測モデルの入力値と予測対象の値を別々にtrain_test_split関数に設定
# test_sizeは検証データの割合
train_data, test_data, train_target, test_target = \
  train_test_split(production_tb.drop('fault_flg', axis=1),
                   production_tb[['fault_flg']],
                   test_size=0.2)

# train_test_splitによって、行名を現在の行番号に直す
train_data.reset_index(inplace=True, drop=True)
test_data.reset_index(inplace=True, drop=True)
train_target.reset_index(inplace=True, drop=True)
test_target.reset_index(inplace=True, drop=True)

# 対象の行番号リストを生成
row_no_list = list(range(len(train_target)))

# 交差検証用のデータ分割
k_fold = KFold(n_splits=4, shuffle=True)

# 交差数分繰り返し処理、並列処理も可能な部分
for train_cv_no, test_cv_no in k_fold.split(row_no_list):

  # 交差検証における学習データを抽出
  train_cv = train_data.iloc[train_cv_no, :]

  # 交差検証における検証データを抽出
  test_cv = train_data.iloc[test_cv_no, :]

  # train_dataとtrain_targetを学習データ、
  # test_dataとtest_targetを検証データとして機械学習モデルの構築、検証

# 交差検証の結果をまとめる

# trainを学習データ、private_testを検証データとして機械学習モデルの構築、検証
