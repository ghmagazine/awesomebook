SELECT
  -- 集約単位のホテルIDの抽出
  hotel_id,

  -- COUNT関数にreserve_idを指定しているので、reserve_idがNULLでない行数をカウント
  COUNT(reserve_id) AS rsv_cnt,

  -- customer_idにdistinctを付け、重複を排除
  -- 重複を排除したcustomer_idの数をカウント
  COUNT(distinct customer_id) AS cus_cnt

FROM work.reserve_tb

-- GROUP BY句で集約する単位をhotel_idに指定
GROUP BY hotel_id
