SELECT
  hotel_id,

  -- total_priceの最大値を算出
  MAX(total_price) AS price_max,

  -- total_priceの最小値を算出
  MIN(total_price) AS price_min,

  -- total_priceの平均値を算出
  AVG(total_price) AS price_avg,

  -- total_priceの中央値を算出
  MEDIAN(total_price) AS price_med,

  -- PERCENTILE_CONT関数に0.2を指定し、20パーセントタイル値を算出
  -- ORDER BY句にtotal_priceを指定し、パーセンタイル値の対象列とデータの並べ方を指定
  PERCENTILE_CONT(0.2) WITHIN GROUP(ORDER BY total_price) AS price_20per

FROM work.reserve_tb
GROUP BY hotel_id
