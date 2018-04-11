-- WITH句によって、一時テーブルreserve_tb_randomを生成
WITH reserve_tb_random AS(
  SELECT
    *,

    -- customer_idに対して一意の値となる乱数の生成
    -- 生成した乱数をcustomer_idごとにまとめて、1番目の値を取り出す
    FIRST_VALUE(RANDOM()) OVER (PARTITION BY customer_id) AS random_num

  FROM work.reserve_tb
)
-- *ですべての列を抽出しているが、random_numを外したい場合は列を指定する必要あり
SELECT *
FROM reserve_tb_random

-- 50%サンプリング、customer_idごとに設定された乱数が0.5以下の場合に抽出
WHERE random_num <= 0.5
