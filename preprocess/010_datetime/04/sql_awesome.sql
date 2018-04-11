WITH tmp_log AS(
  SELECT
    -- reserve_datetimeをTIMESTAMP型へ変換
    CAST(
      TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
    ) AS reserve_datetime,

    -- reserve_dateをDATE型へ変換
    TO_DATE(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS reserve_date

  FROM work.reserve_tb
)
SELECT
  -- reserve_datetimeに1日加える
  reserve_datetime + interval '1 day' AS reserve_datetime_1d,

  -- reserve_dateに1日加える
  reserve_date + interval '1 day' AS reserve_date_1d,

  -- reserve_datetimeに1時間加える
  reserve_datetime + interval '1 hour' AS reserve_datetime_1h,

  -- reserve_datetimeに1分加える
  reserve_datetime + interval '1 minute' AS reserve_datetime_1m,

  -- reserve_datetimeに1秒加える
  reserve_datetime + interval '1 second' AS reserve_datetime_1s

FROM tmp_log
