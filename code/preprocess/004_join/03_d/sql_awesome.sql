SELECT
	-- 結合元のデータ列をすべて取得
  base.*,

	-- 対象の件数が0件の場合は0、1件以上ある場合は合計金額を計算
  COALESCE(SUM(combine.total_price), 0) AS price_sum

-- 結合元の予約テーブルの指定
FROM work.reserve_tb base

-- 過去の情報として結合する予約テーブルの指定
LEFT JOIN work.reserve_tb combine

	-- 同じcustomer_id同士で結合
  ON base.customer_id = combine.customer_id

	-- 過去のデータのみを結合対象として指定
  AND base.reserve_datetime > combine.reserve_datetime

	-- 90日前までの過去のデータのみを結合対象として指定(「第10章 日時型」で詳しく解説)
  AND DATEADD(day, -90, base.reserve_datetime) <= combine.reserve_datetime

-- 結合元の予約テーブルのすべてのデータ列で集約
GROUP BY base.reserve_id, base.hotel_id, base.customer_id,
  base.reserve_datetime, base.checkin_date, base.checkin_time, base.checkout_date,
  base.people_num, base.total_price
