WITH rsv_cnt_table AS(
  SELECT
    -- Round関数によって四捨五入し、total_priceを1000単位の値に変換
    ROUND(total_price, -3) AS total_price_round,

    -- COUNT関数で金額別の予約数を算出
    COUNT(*) AS rsv_cnt

  FROM work.reserve_tb

  -- ASで新たに命名した列名total_price_roundを指定して、予約金額の1000単位で集約
  GROUP BY total_price_round
)
SELECT
  total_price_round
FROM rsv_cnt_table

-- ()内のクエリによって最頻値の値を取得し、WHERE句で最頻値と一致するものを抽出
WHERE rsv_cnt = (SELECT max(rsv_cnt) FROM rsv_cnt_table)
