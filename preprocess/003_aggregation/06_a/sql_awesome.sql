SELECT
  *,

  -- ROW_NUMBERで順位を取得
  -- PARTITION by customer_idで顧客ごとに順位を取得するよう設定
  -- ORDER BY reserve_datetimeで順位を予約日時の古い順に設定
  ROW_NUMBER()
    OVER (PARTITION BY customer_id ORDER BY reserve_datetime) AS log_no

FROM work.reserve_tb
