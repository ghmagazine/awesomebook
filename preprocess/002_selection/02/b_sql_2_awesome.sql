SELECT *
FROM work.reserve_tb

-- インデックスを効かせるために、checkin_dateでも絞り込み
WHERE checkin_date BETWEEN '2016-10-10' AND '2016-10-13'
  AND checkout_date BETWEEN '2016-10-13' AND '2016-10-14'
