SELECT
  -- 男性フラグを生成
  CASE WHEN sex = 'man' THEN TRUE ELSE FALSE END AS sex_is_man,

  -- 女性フラグを生成
	CASE WHEN sex = 'woman' THEN TRUE ELSE FALSE END AS sex_is_woman

FROM work.customer_tb
