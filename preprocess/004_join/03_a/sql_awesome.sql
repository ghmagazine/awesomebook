SELECT
	*,

	-- LAG関数を利用し、2件前のtotal_priceをbefore_priceとして取得
	-- LAG関数によって参照する際のグループをcustomer_idに指定
	-- LAG関数によって参照する際のグループ内のデータをreserve_datetimeの古い順に指定
  LAG(total_price, 2) OVER
	(PARTITION BY customer_id ORDER BY reserve_datetime) AS before_price

FROM work.reserve_tb