SELECT
	*,

  -- 10刻みの値に変更
	FLOOR(age / 10) * 10 AS age_rank

FROM work.customer_tb
