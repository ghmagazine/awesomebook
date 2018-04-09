CREATE TABLE work.customer_category_mst AS(
  SELECT
    -- カテゴリのインデックス番号作成（0スタートになるように1を引く）
    ROW_NUMBER() OVER() - 1 AS customer_category_no,

    customer_id
  FROM work.reserve_tb rsv

  -- レコメンデーション対象のデータに出てくる顧客のみに絞り込み
  WHERE rsv.checkin_date >= '2016-01-01'
    AND rsv.checkin_date < '2017-01-01'

  GROUP BY customer_id
)