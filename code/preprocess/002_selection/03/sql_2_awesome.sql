SELECT *
FROM work.reserve_tb

-- 乱数を生成し、0.5以下のデータ行のみ絞り込み
WHERE RANDOM() <= 0.5
