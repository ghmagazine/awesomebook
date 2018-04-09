SELECT *
FROM work.reserve_tb

-- WHERE句によって、抽出するデータの条件を指定
-- checkin_dateが、2016-10-12以降のデータに絞り込み
WHERE checkin_date >= '2016-10-12'

  -- 複数の条件を指定する場合に、WHERE句以降にAND句を追加
  -- checkin_dateが、2016-10-13以前のデータに絞り込み
  AND checkin_date <= '2016-10-13'
