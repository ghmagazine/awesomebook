-- SEXのカテゴリマスタを生成
WITH sex_mst AS(
	SELECT
    sex,
    ROW_NUMBER() OVER() AS sex_mst_id
	FROM work.customer_tb
	GROUP BY sex
)
SELECT
  base.*,
  s_mst.sex_mst_id
FROM work.customer_tb base
INNER JOIN sex_mst s_mst
  ON base.sex = s_mst.sex