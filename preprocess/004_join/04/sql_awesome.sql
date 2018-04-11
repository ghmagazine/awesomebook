SELECT
	cus.customer_id,

	-- 年月マスタから年を取得
	mst.year_num,

	-- 年月マスタから月を取得
	mst.month_num,

	-- 該当のtotal_priceがある場合は足し合わせ、ない場合は0を足し合わせる
	SUM(COALESCE(rsv.total_price, 0)) AS total_price_month

FROM work.customer_tb cus

-- 顧客テーブルと年月マスタと全結合
CROSS JOIN work.month_mst mst

-- 顧客テーブルと年月マスタと予約テーブルを結合
LEFT JOIN work.reserve_tb rsv
  ON cus.customer_id = rsv.customer_id
    AND mst.month_first_day <= rsv.checkin_date
    AND mst.month_last_day >= rsv.checkin_date

-- 年月マスタの対象期間を絞り込み
WHERE mst.month_first_day >= '2017-01-01'
  AND mst.month_first_day < '2017-04-01'
GROUP BY cus.customer_id, mst.year_num, mst.month_num
