SELECT
  -- timestamptzに変換
  TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS')
    AS reserve_datetime_timestamptz,

  -- timestamptzに変換後に、timestampに変換
  CAST(
    TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
  ) AS reserve_datetime_timestamp,

  -- 日付と時刻の文字結合してから、TIMESTAMPに変換
  TO_TIMESTAMP(checkin_date || checkin_time, 'YYYY-MM-DDHH24:MI:SS')
    AS checkin_timestamptz,

  -- 日時文字列を日付型に変換（時刻情報は変換後削除されている）
  TO_DATE(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS reserve_date,

  -- 日付文字列を日付型に変換
  TO_DATE(checkin_date, 'YYYY-MM-DD') AS checkin_date

FROM work.reserve_tb
