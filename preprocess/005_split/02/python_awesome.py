from preprocess.load_data.data_loader import load_monthly_index
monthly_index_tb = load_monthly_index()

# 下の行から本書スタート
# train_window_startに、最初の学習データの開始行番号を指定
train_window_start = 1
# train_window_endに、最初の学習データの終了行番号を指定
train_window_end = 24
# horizonに、検証データのデータ数を指定
horizon = 12
# skipにスライドするデータ数を設定
skip = 12

# 年月に基づいてデータを並び替え
monthly_index_tb.sort_values(by='year_month')

while True:
  # 検証データの終了行番号を計算
  test_window_end = train_window_end + horizon

  # 行番号を指定して、元データから学習データを取得
  # train_window_startの部分を1に固定すれば、学習データを増やしていく検証に変更可能
  train = monthly_index_tb[train_window_start:train_window_end]

  # 行番号を指定して、元データから検証データを取得
  test = monthly_index_tb[(train_window_end + 1):test_window_end]

  # 検証データの終了行番号が元データの行数以上になっているか判定
  if test_window_end >= len(monthly_index_tb.index):
    # 全データを対象にした場合終了
    break

  # データをスライドさせる
  train_window_start += skip
  train_window_end += skip

# 交差検定の結果をまとめる
