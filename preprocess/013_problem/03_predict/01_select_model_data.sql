WITH target_customer_month_log AS(
  -- データ構造をわかりやすくするために、2段階のWithを利用
  -- 顧客テーブルと月マスタテーブルを全結合して、予測単位の基本となるデータを構築
  WITH customer_month_log AS(
    SELECT
      cus.customer_id,
      cus.age,
      cus.sex,
      mst.year_num,
      mst.month_num,
      TO_DATE(mst.month_first_day, 'YYYY-MM-DD') AS month_first_day,
      TO_DATE(mst.month_last_day, 'YYYY-MM-DD') AS month_last_day
    FROM work.customer_tb cus
    CROSS JOIN work.month_mst mst

    -- 期間は2016-04-01から2017-04-01の1年間ではなく、それよりも過去に3ヶ月長くしている
    -- 理由は、後段で最大3ヶ月前の予約フラグを説明変数として加えているため
    WHERE mst.month_first_day >= '2016-01-01'
      AND mst.month_first_day < '2017-04-01'
  )
  -- 予約テーブルを結合し、予約フラグを付与
  -- 後段に、説明変数を作るために予約テーブルと再度結合する処理があり、
  -- 処理をまとめることもできるが、今回はわかりやすくするために分割
  , tmp_rsvflg_log AS(
    SELECT
      base.customer_id,
      base.sex,
      base.age,
      base.year_num,
      base.month_num,
      base.month_first_day,

      -- 予約フラグを作成
      CASE WHEN COUNT(target_rsv.reserve_id) > 0 THEN 1 ELSE 0 END
        AS rsv_flg

    FROM customer_month_log base

    -- 対象月の期間に該当する予約テーブルを結合
    LEFT JOIN work.reserve_tb target_rsv
      ON base.customer_id = target_rsv.customer_id
      AND TO_DATE(target_rsv.reserve_datetime, 'YYYY-MM-DD HH24:MI:SS')
          BETWEEN base.month_first_day AND base.month_last_day

    GROUP BY base.customer_id,
             base.sex,
             base.age,
             base.year_num,
             base.month_num,
             base.month_first_day
  )
  -- LAG関数を用いて、1〜3ヶ月前の予約フラグを付与
  , rsvflg_log AS(
    SELECT
      *,

      -- 1ヶ月前の予約フラグ
      LAG(rsv_flg, 1) OVER(PARTITION BY customer_id
                           ORDER BY month_first_day)
        AS before_rsv_flg_m1,

      -- 2ヶ月前の予約フラグ
      LAG(rsv_flg, 2) OVER(PARTITION BY customer_id
                           ORDER BY month_first_day)
        AS before_rsv_flg_m2,

      -- 3ヶ月前の予約フラグ
      LAG(rsv_flg, 3) OVER(PARTITION BY customer_id
                           ORDER BY month_first_day)
        AS before_rsv_flg_m3

    FROM tmp_rsvflg_log
  )
  -- 顧客ごとに特定の月のデータをサンプリングするために、乱数による順位を付与
  , rsvflg_target_log AS(
    SELECT
      *,

      -- 乱数による順位を計算
      ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY RANDOM())
        AS random_rank

    FROM rsvflg_log

    -- 2016年度（2016-04-01から2017-03-31）のデータに絞る
    WHERE month_first_day >= '2016-04-01'
      AND month_first_day < '2017-04-01'
  )
  -- 乱数による順位を利用して、ランダムサンプリング
  SELECT * FROM rsvflg_target_log where random_rank = 1
)
-- 過去1年間（365日間）の予約レコードと結合して、説明変数を作るためのデータを準備
, rsvflg_and_history_rsv_log AS(
  SELECT
    base.*,
    before_rsv.reserve_id AS before_reserve_id,

    -- 予約日に変換
    TO_DATE(before_rsv.reserve_datetime, 'YYYY-MM-DD HH24:MI:SS')
      AS before_reserve_date,
    before_rsv.total_price AS before_total_price,

    -- 宿泊人数1人フラグを計算
    CASE WHEN before_rsv.people_num = 1 THEN 1 ELSE 0 END
      AS before_people_num_1,

    -- 宿泊人数2人以上フラグを計算
    CASE WHEN before_rsv.people_num >= 2 THEN 1 ELSE 0 END
      AS before_people_num_over2,

    -- 過去の宿泊月が同じ月（年は違ってもよい）であるかどうかのフラグを計算
    CASE
      WHEN base.month_num =
        CAST(DATE_PART(MONTH, TO_DATE(before_rsv.reserve_datetime,
                                      'YYYY-MM-DD HH24:MI:SS')) AS INT)
        THEN 1 ELSE 0 END AS before_rsv_target_month

  FROM target_customer_month_log base

  -- 同じ顧客の過去1年間（365日間）の予約テーブルを結合
  LEFT JOIN work.reserve_tb before_rsv
    ON base.customer_id = before_rsv.customer_id
    AND TO_DATE(before_rsv.checkin_date, 'YYYY-MM-DD')
        BETWEEN DATEADD(DAY, -365,
                        TO_DATE(base.month_first_day, 'YYYY-MM-DD'))
            AND DATEADD(DAY, -1,
                        TO_DATE(base.month_first_day, 'YYYY-MM-DD'))
)
-- 結合した過去1年間の予約レコードを集約して、説明変数に変換
--（前段のSQLと処理をまとめることも可能）
SELECT
  customer_id,
  rsv_flg,
  sex,
  age,
  month_num,
  before_rsv_flg_m1,
  before_rsv_flg_m2,
  before_rsv_flg_m3,

  -- 過去1年間の予約金額の合計を計算（予約がない場合は、0円として補完）
  COALESCE(SUM(before_total_price), 0) AS before_total_price,

  -- 過去1年間の予約回数
  COUNT(before_reserve_id) AS before_rsv_cnt,

  -- 過去1年間の宿泊人数1人で予約した回数
  SUM(before_people_num_1) AS before_rsv_cnt_People_num_1,

  -- 過去1年間の宿泊人数2人以上で予約した回数
  SUM(before_people_num_over2) AS before_rsv_cnt_People_num_over2,

  -- 最近の予約の日時が何日前なのかを計算
  -- （最近の予約が見付からない場合は、1年前（365日前）+1日前の366で補完）
  COALESCE(DATEDIFF(day, MAX(before_reserve_date), month_first_day), 0)
    AS last_rsv_day_diff,

  -- 過去1年間の同じ月の予約回数を計算
  SUM(before_rsv_target_month) AS before_rsv_cnt_target_month

FROM rsvflg_and_history_rsv_log
GROUP BY
  customer_id,
  sex,
  age,
  month_num,
  before_rsv_flg_m1,
  before_rsv_flg_m2,
  before_rsv_flg_m3,
  month_first_day,
  rsv_flg,
  month_first_day
