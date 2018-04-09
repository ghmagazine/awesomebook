SELECT
	-- 必要な列の抽出
	rsv.reserve_id, rsv.hotel_id, rsv.customer_id,
  rsv.reserve_datetime, rsv.checkin_date, rsv.checkin_time, rsv.checkout_date,
  rsv.people_num, rsv.total_price,
  hotel.base_price, hotel.big_area_name, hotel.small_area_name,
  hotel.hotel_latitude, hotel.hotel_longitude, hotel.is_business

FROM work.reserve_tb rsv
JOIN work.hotel_tb hotel
  ON rsv.hotel_id = hotel.hotel_id

-- ホテルテーブルからビジネスホテルのデータのみ抽出
WHERE hotel.is_business is True

	-- 予約テーブルからビジネスホテルのデータのみ抽出
  AND rsv.people_num = 1
