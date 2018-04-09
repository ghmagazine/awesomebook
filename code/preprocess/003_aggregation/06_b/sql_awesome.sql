SELECT
  hotel_id,

  -- RANK関数で予約数の順位を指定
  -- COUNT(*)をRANKの基準として指定(集約したあとの予約数に対して順位を付ける算出処理)
  -- DESCを付けることによって、降順を指定
  RANK() OVER (ORDER BY COUNT(*) DESC) AS rsv_cnt_rank

FROM work.reserve_tb

-- hotel_idを集約単位に指定、予約数を計算するための集約指定でRANK関数には関係なし
GROUP BY hotel_id
