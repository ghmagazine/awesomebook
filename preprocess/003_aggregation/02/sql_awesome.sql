SELECT
  hotel_id,
  people_num,

  -- SUM関数にtotal_priceを指定し、売上合計金額を算出
  SUM(total_price) AS price_sum

FROM work.reserve_tb

-- 集約単位をhotel_idとpeople_numの組み合わせに指定
GROUP BY hotel_id, people_num
