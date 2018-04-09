SELECT
  type,
  length,

  -- thicknessの欠損値を1で補完
  COALESCE(thickness, 1) AS thickness,
  fault_flg
FROM work.production_missn_tb
