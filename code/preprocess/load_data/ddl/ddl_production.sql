CREATE TABLE work.production_tb
(
  type TEXT NOT NULL,
  length FLOAT NOT NULL,
  thickness FLOAT NOT NULL,
  fault_flg BOOLEAN NOT NULL
);

COPY work.production_tb
FROM 's3://awesomebk/production.csv'
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'
CSV IGNOREHEADER AS 1;
