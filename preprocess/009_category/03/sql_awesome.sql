WITH customer_tb_with_age_rank AS(
  SELECT
    *,

    -- 年齢を10才区切りでカテゴリ化
    CAST(FLOOR(age / 10) * 10 AS TEXT) AS age_rank

  FROM work.customer_tb
)
SELECT
  customer_id, age, sex, home_latitude, home_longitude,

  -- カテゴリを集約
  CASE WHEN age_rank = '60' OR age_rank = '70' OR age_rank = '80'
    THEN '60才以上' ELSE age_rank END AS age_rank

FROM customer_tb_with_age_rank
