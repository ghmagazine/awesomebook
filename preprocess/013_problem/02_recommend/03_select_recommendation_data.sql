SELECT
  c_mst.customer_category_no,
  h_mst.hotel_category_no,

	-- 予約数を計算
  COUNT(rsv.reserve_id) AS rsv_cnt

FROM work.reserve_tb rsv

-- 顧客のカテゴリマスタと結合
INNER JOIN work.customer_category_mst c_mst
  ON rsv.customer_id = c_mst.customer_id

-- ホテルのカテゴリマスタと結合
INNER JOIN work.hotel_category_mst h_mst
  ON rsv.hotel_id = h_mst.hotel_id

-- レコメンデーション対象のデータに出てくるホテルのみに絞り込み
WHERE rsv.checkin_date >= '2016-01-01'
  AND rsv.checkin_date < '2017-01-01'

GROUP BY c_mst.customer_category_no,
		     h_mst.hotel_category_no
