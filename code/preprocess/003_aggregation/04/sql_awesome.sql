SELECT
  hotel_id,

  -- VARIANCE関数にtotal_priceを指定し、分散値を算出
  -- COALESCE関数によって、分散値がNULLのときは0に変換
  COALESCE(VARIANCE(total_price), 0) AS price_var,

  -- データ数が2件以上の場合は、STDDEV関数にtotal_priceを指定し、標準偏差値を算出
  COALESCE(STDDEV(total_price), 0) AS price_std

FROM work.reserve_tb
GROUP BY hotel_id