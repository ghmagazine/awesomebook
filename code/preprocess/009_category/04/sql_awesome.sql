SELECT
  *,

  -- sexと年齢の10才区切りのカテゴリ値を文字列として間に"_"を加えて結合
  sex || '_' || CAST(FLOOR(age / 10) * 10 AS TEXT) AS sex_and_age

FROM work.customer_tb
