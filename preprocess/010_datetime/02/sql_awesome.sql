WITH tmp_log AS(
	SELECT
		CAST(
      TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
    ) AS reserve_datetime_timestamp,
	FROM work.reserve_tb
)
SELECT
	-- DATE型もDATE_PART関数は利用可
	-- TIMESTAMPTZ型はDATE_PART関数は利用不可
	-- 年を取得
	DATE_PART(year, reserve_datetime_timestamp)
	  AS reserve_datetime_year,

  -- 月を取得
	DATE_PART(month, reserve_datetime_timestamp)
	  AS reserve_datetime_month,

  -- 日を取得
	DATE_PART(day, reserve_datetime_timestamp)
	  AS reserve_datetime_day,

  -- 曜日(0 は日曜日、1＝月曜日)を取得
	DATE_PART(dow, reserve_datetime_timestamp)
	  AS reserve_datetime_day,

  -- 時刻の時を取得
	DATE_PART(hour, reserve_datetime_timestamp)
	  AS reserve_datetime_hour,

  -- 時刻の分を取得
	DATE_PART(minute, reserve_datetime_timestamp)
	  AS reserve_datetime_minute,

  -- 時刻の秒を取得
	DATE_PART(second, reserve_datetime_timestamp)
	  AS reserve_datetime_second,

  -- 指定したフォーマットの文字列に変換
	TO_CHAR(reserve_datetime_timestamp, 'YYYY-MM-DD HH24:MI:SS')
	  AS reserve_datetime_char

FROM tmp_log
