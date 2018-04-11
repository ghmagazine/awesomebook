-- small_area_nameごとにホテル数をカウント、結合キーを判定するためのテーブル
WITH small_area_mst AS(
  SELECT
    small_area_name,

    -- 20件以上であればjoin_area_idをsmall_area_nameとして設定
    -- 20件未満であればjoin_area_idをbig_area_nameとして設定
    -- -1は、自ホテルを引いている
    CASE WHEN COUNT(hotel_id)-1 >= 20
			THEN small_area_name ELSE big_area_name END AS join_area_id

  FROM work.hotel_tb
  GROUP BY big_area_name, small_area_name
)
-- recommend_hotel_mstはレコメンド候補のためのテーブル
, recommend_hotel_mst AS(
  -- join_area_idをbig_area_nameとしたレコメンド候補マスタ
  SELECT
    big_area_name AS join_area_id,
    hotel_id AS rec_hotel_id
  FROM work.hotel_tb

  -- unionで、テーブル同士を連結
  UNION

  -- join_area_idをsmall_area_nameとしたレコメンド候補マスタ
  SELECT
    small_area_name AS join_area_id,
    hotel_id AS rec_hotel_id
  FROM work.hotel_tb
)
SELECT
  hotels.hotel_id,
  r_hotel_mst.rec_hotel_id

-- レコメンド元のhotel_tbを読み込み
FROM work.hotel_tb hotels

-- 各ホテルのレコメンド候補の対象エリアを判断するためにsmall_area_mstを結合
INNER JOIN small_area_mst s_area_mst
  ON hotels.small_area_name = s_area_mst.small_area_name

-- 対象エリアのレコメンド候補を結合する
INNER JOIN recommend_hotel_mst r_hotel_mst
  ON s_area_mst.join_area_id = r_hotel_mst.join_area_id

  -- レコメンド候補から自分ホテルを除く
  AND hotels.hotel_id != r_hotel_mst.rec_hotel_id
