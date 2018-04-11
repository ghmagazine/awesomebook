SELECT
  type,
  length,
  COALESCE(thickness,
           (SELECT AVG(thickness) FROM work.production_missn_tb))
    AS thickness,
  fault_flg
FROM work.production_missn_tb
