SELECT
  CASE WHEN sex = 'man' THEN TRUE ELSE FALSE END AS sex_is_man
FROM work.customer_tb