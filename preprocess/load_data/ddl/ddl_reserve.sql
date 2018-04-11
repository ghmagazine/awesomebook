-- 作成するテーブルの名前をwork.reserve_tbとして指定
CREATE TABLE work.reserve_tb
(
  -- reserve_idの列を設定（データ型は文字列、NULL値をとらない制約を追加）
  reserve_id TEXT NOT NULL,

  -- hotel_idの列を設定（データ型は文字列、NULL値をとらない制約を追加）
  hotel_id TEXT NOT NULL,

  -- customer_idの列を設定（データ型は文字列、NULL値をとらない制約を追加）
  customer_id TEXT NOT NULL,

  -- reserve_datetimeの列を設定（データ型はタイムスタンプ）
  -- NULL値をとらない制約を追加
  reserve_datetime TIMESTAMP NOT NULL,

  -- checkin_dateの列を設定（データ型は日付、NULL値をとらない制約を追加）
  checkin_date DATE NOT NULL,

  -- checkin_timeの列を設定（データ型は文字列、NULL値をとらない制約を追加）
  checkin_time TEXT NOT NULL,

  -- checkout_dateの列を設定（データ型は日付、NULL値をとらない制約を追加）
  checkout_date DATE NOT NULL,

  -- people_numの列を設定（データ型は整数、NULL値をとらない制約を追加）
  people_num INTEGER NOT NULL,

  -- total_priceの列を設定（データ型は整数、NULL値をとらない制約を追加）
  total_price INTEGER NOT NULL,

  -- 主キー（テーブルの中で一意の値となる列）をreserve_idとして設定
  PRIMARY KEY(reserve_id),

  -- 外部キー（他のテーブルと同じ内容を示す列）をhotel_idに設定
  -- 対象は、ホテルマスタのホテルID
  -- 対象のKeyを持っているテーブルは、作成済みである必要がある
  -- 対象のKeyは、PRIMARY KEYに指定されている必要がある
  FOREIGN KEY(hotel_id) REFERENCES work.hotel_tb(hotel_id),

  -- 外部キー（他のテーブルと同じ内容を示す列）をcustomer_idに設定
  -- 対象は、顧客マスタの顧客ID
  FOREIGN KEY(customer_id) REFERENCES work.customer_tb(customer_id)
)
-- データの分散方法をKEY（指定した列の値に応じて分散）に設定
DISTSTYLE KEY

-- 分散KEYをcheckin_dateに設定
DISTKEY (checkin_date);

-- データをロードするテーブルをwork.reserve_tbに指定
COPY work.reserve_tb

-- データのロード元となるcsvファイルをS3上にあるreserve.csvに指定
FROM 's3://awesomebk/reserve.csv'

-- S3にアクセスするためのAWSの認証情報を設定
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'

-- 利用するリージョン（クラウドサービスの地域）を指定
REGION AS 'us-east-1'

-- CSVファイルの1行目には列名が入っているので、それをデータロードしないように設定
CSV IGNOREHEADER AS 1

-- DATE型に変換するときのフォーマットを指定
DATEFORMAT 'YYYY-MM-DD'

-- TIMESTAMP型に変換するときのフォーマットを指定
TIMEFORMAT 'YYYY-MM-DD HH:MI:SS';
