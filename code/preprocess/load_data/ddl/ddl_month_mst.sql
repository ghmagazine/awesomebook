CREATE TABLE work.month_mst
(
  year_num          INTEGER NOT NULL,
  month_num         INTEGER NOT NULL,
  month_first_day   TEXT NOT NULL,
  month_last_day    TEXT NOT NULL
);

COPY work.month_mst
FROM 's3://awesomebk/month_mst.csv'
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'
REGION AS 'us-east-1'
CSV IGNOREHEADER AS 1;
