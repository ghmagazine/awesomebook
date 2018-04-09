CREATE TABLE work.customer_tb
(
  customer_id      TEXT NOT NULL,
  age         	   INTEGER NOT NULL,
  sex      		   TEXT NOT NULL,
  home_latitude    FLOAT NOT NULL,
  home_longitude   FLOAT NOT NULL,
  primary key(customer_id)
)
DISTSTYLE KEY
DISTKEY (customer_id);

COPY work.customer_tb
FROM 's3://awesomebk/customer.csv'
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'
REGION AS 'us-east-1'
CSV IGNOREHEADER AS 1;
