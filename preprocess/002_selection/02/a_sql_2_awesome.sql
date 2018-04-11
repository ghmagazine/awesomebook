SELECT *
FROM work.reserve_tb

-- checkin_dateが、2016-10-12から2016-10-13までのデータに絞り込み
WHERE checkin_date BETWEEN '2016-10-12' AND '2016-10-13'
