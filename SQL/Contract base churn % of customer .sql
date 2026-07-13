SELECT
  contract,
  CONCAT(
    ROUND(
      100 * SUM(
          CASE
            WHEN customer_status = 'Churned' THEN 1 ELSE 0
          END)/ COUNT(c.customer_id),2),' %') AS churn_rate,
  ROUND(AVG(p.total_charges), 2) AS avg_total_charges,
  ROUND(AVG(c.tenure_in_months), 2) AS avg_tenure
FROM `Telecom_cust_churn.customer` c
JOIN Telecom_cust_churn.payment p
  ON c.customer_id = p.customer_id
GROUP BY contract
