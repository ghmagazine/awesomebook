SELECT
	base.*,

  -- 休日フラグを付与
  mst.holidayday_flg,

  -- 休日フラグを付与
  mst.nextday_is_holiday_flg

FROM work.reserve_tb base

-- 休日マスタと結合
INNER JOIN work.holiday_mst mst
  ON base.checkin_date = mst.target_day
