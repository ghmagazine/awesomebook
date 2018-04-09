SELECT
  -- 整数型へ変換
  -- 40000/3と記述すると整数型として計算され、少数点以下が計算されない
  CAST((40000.0 / 3) AS INT2) AS v_int2,
  CAST((40000.0 / 3) AS INT4) AS v_int4,
  CAST((40000.0 / 3) AS INT8) AS v_int8,

  -- 浮動小数点型へ変換
  CAST((40000.0 / 3) AS FLOAT4) AS v_float4,
  CAST((40000.0 / 3) AS FLOAT8) AS v_float8

-- テーブルのデータは関係ないですが、上記を計算するために指定
FROM work.reserve_tb
LIMIT 1
