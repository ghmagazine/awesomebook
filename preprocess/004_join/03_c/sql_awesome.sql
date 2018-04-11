SELECT
  *,

  AVG(total_price) OVER
	(PARTITION BY customer_id ORDER BY checkin_date ROWS
	 BETWEEN 3 PRECEDING AND 1 PRECEDING) AS price_avg

FROM work.reserve_tb
