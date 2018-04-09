SELECT
  cus.customer_id,
  cus.age,
  cus.sex,
  rsv.hotel_id,
  rsv.people_num,
  rsv.total_price
FROM work.reserve_tb rsv

-- 顧客情報を結合
INNER JOIN work.customer_tb cus
  ON rsv.customer_id = cus.customer_id

-- 集計の対象期間を設定
WHERE rsv.checkin_date >= '2016-01-01'
  AND rsv.checkin_date < '2017-01-01'
