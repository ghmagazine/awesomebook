-- 予約テーブルとホテルテーブルをすべて結合
WITH rsv_and_hotel_tb AS(
	SELECT
		-- 必要な列の抽出
	  rsv.reserve_id, rsv.hotel_id, rsv.customer_id,
	  rsv.reserve_datetime, rsv.checkin_date, rsv.checkin_time,
		rsv.checkout_date, rsv.people_num, rsv.total_price,
	  hotel.base_price, hotel.big_area_name, hotel.small_area_name,
	  hotel.hotel_latitude, hotel.hotel_longitude, hotel.is_business

	-- 結合元となるreserve_tbを選択、テーブルの短縮名をrsvに設定
	FROM work.reserve_tb rsv

	-- 結合するhotel_tbを選択、テーブルの短縮名をhotekに設定
	INNER JOIN work.hotel_tb hotel
		-- 結合の条件を指定、hotel_idが同じレコード同士を結合
	  ON rsv.hotel_id = hotel.hotel_id
)
-- 結合したテーブルから条件に適合するデータのみ抽出
SELECT * FROM rsv_and_hotel_tb

-- is_businessのデータのみ抽出
WHERE is_business is True

	-- people_numが1人のデータのみ抽出
  AND people_num = 1
