-- 製品種別ごとの製造数と障害数の計算
WITH type_mst AS(
	SELECT
		type,

    -- 製造数
		COUNT(*) AS record_cnt,

    -- 障害数
		SUM(CASE WHEN fault_flg THEN 1 ELSE 0 END) AS fault_cnt

	FROM work.production_tb
	GROUP BY type
)
SELECT
  base.*,

  -- 自身のレコードを除いた製品種別ごとの平均障害率
  CAST(t_mst.fault_cnt - (CASE WHEN fault_flg THEN 1 ELSE 0 END) AS FLOAT) /
    (t_mst.record_cnt - 1) AS type_fault_rate

FROM work.production_tb base
INNER JOIN type_mst t_mst
  ON base.type = t_mst.type
