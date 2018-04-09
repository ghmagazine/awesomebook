SELECT *
FROM work.reserve_tb

-- データ行ごとに乱数を生成し、乱数の小さい順にデータを並び替え
ORDER BY RANDOM()

-- サンプリングする件数をLIMIT句で指定
-- 事前にカウントしたデータ数を入力し、抽出する割合をかけ、ROUNDによって四捨五入
LIMIT ROUND(120000 * 0.5)
