CREATE TABLE work.production_missn_tb
(
  type TEXT NOT NULL,
  length FLOAT NOT NULL,
  thickness FLOAT,
  fault_flg BOOLEAN NOT NULL
);

COPY work.production_missn_tb
FROM 's3://awesomebk/production_missing_num_4_redshift.csv'
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'
CSV IGNOREHEADER AS 1;
