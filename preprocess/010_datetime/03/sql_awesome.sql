WITH tmp_log AS(
  SELECT
    -- reserve_datetimeをTIMESTAMP型へ変換
    CAST(
      TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
    ) AS reserve_datetime,

    -- checkin_datetimeをTIMESTAMP型へ変換
    CAST(
      TO_TIMESTAMP(checkin_date || checkin_time, 'YYYY-MM-DDHH24:MI:SS')
      AS TIMESTAMP
    ) AS checkin_datetime

  FROM work.reserve_tb
)
SELECT
  -- 年の差を計算（月以下の日時要素は考慮しない）
	DATEDIFF(year, reserve_datetime, checkin_datetime) AS diff_year,

  -- 月の差を取得（日以下の日時要素は考慮しない）
	DATEDIFF(month, reserve_datetime, checkin_datetime) AS diff_month,

  -- 下記3つは問題には該当しないが参考までに

  -- 日の差分を計算（時間以下の日時要素は考慮しない）
	DATEDIFF(day, reserve_datetime, checkin_datetime) AS diff_day,

  -- 時の差分を計算（分以下の日時要素は考慮しない）
	DATEDIFF(hour, reserve_datetime, checkin_datetime) AS diff_hour,

  -- 分の差分を計算（秒以下の日時要素は考慮しない）
	DATEDIFF(minute, reserve_datetime, checkin_datetime) AS diff_minute,

  -- 日単位で差分を計算
	CAST(DATEDIFF(second, reserve_datetime, checkin_datetime) AS FLOAT) /
    (60 * 60 * 24) AS diff_day2,

  -- 時間単位で差分を計算
	CAST(DATEDIFF(second, reserve_datetime, checkin_datetime) AS FLOAT) /
	  (60 * 60) AS diff_hour2,

  -- 分単位で差分を計算
  CAST(DATEDIFF(second, reserve_datetime, checkin_datetime) AS FLOAT) /
    60 AS diff_minute2,

  -- 秒単位で差分を計算
	DATEDIFF(second, reserve_datetime, checkin_datetime) AS diff_second
FROM tmp_log
