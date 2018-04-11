WITH tmp_log AS(
  SELECT
    -- reserve_datetimeをTIMESTAMP型へ変換し、月を取得
    DATE_PART(
      month,
      CAST(
        TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
      )
    ) AS reserve_month

  FROM work.reserve_tb
)
SELECT
  CASE
    -- 月が3以上5以下の場合、springを返す
    WHEN 3 <= reserve_month and reserve_month <= 5 THEN 'spring'

    -- 月が6以上8以下の場合、springを返す
    WHEN 6 <= reserve_month and reserve_month <= 8 THEN 'summer'

    -- 月が9以上11以下の場合、autumnを返す
    WHEN 9 <= reserve_month and reserve_month <= 11 THEN 'autumn'

    -- 上記の全てに当てはまらない場合（月が1,2,12の場合）、winterを返す
    ELSE 'winter' END

  AS reserve_season
FROM tmp_log
