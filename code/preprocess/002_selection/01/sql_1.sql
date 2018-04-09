SELECT
  -- reserve_idを選択（ASを利用して名前をrsv_timeに変更）
  reserve_id AS rsv_time,

  -- hotel_id,customer_id,reserve_datetimeを選択
  hotel_id, customer_id, reserve_datetime,

  -- checkin_date, checkin_time, checkout_dateを選択
  checkin_date, checkin_time, checkout_date

FROM work.reserve_tb