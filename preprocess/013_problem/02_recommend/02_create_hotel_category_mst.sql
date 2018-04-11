CREATE TABLE work.hotel_category_mst AS(
  SELECT
    -- カテゴリのインデックス番号作成
	  ROW_NUMBER() OVER() - 1 AS hotel_category_no,

	  hotel_id
	FROM work.reserve_tb rsv

	-- レコメンデーション対象のデータに出てくるホテルのみに絞り込み
	WHERE rsv.checkin_date >= '2016-01-01'
	  AND rsv.checkin_date < '2017-01-01'

	GROUP BY hotel_id
)
