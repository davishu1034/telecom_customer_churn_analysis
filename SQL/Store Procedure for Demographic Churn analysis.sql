CREATE OR REPLACE PROCEDURE `telecom-customer-churn-pro01.Telecom_cust_churn.Demographic`(min_age INT64, dependents STRING, married_status BOOL)
BEGIN

  WITH base AS (
  SELECT
    COUNT(customer_id) AS count_of_customer,
    sum(
      CASE
        WHEN customer_status = 'Churned' THEN 1
        ELSE 0
      END) AS count_of_churn_customer
  FROM Telecom_cust_churn.customer
  WHERE (min_age IS NULL OR age >= min_age)
        AND (
          dependents IS NULL
          OR (dependents = '0' AND number_of_dependents = 0)
          OR (dependents = '>0' AND number_of_dependents > 0))
        AND (married_status IS NULL OR married = married_status)
  )
  SELECT
    count_of_customer,
    count_of_churn_customer,
    concat(round(100 * count_of_churn_customer / count_of_customer, 2), ' %') AS churn_rate
  FROM base;

END;