SELECT 
  churn_category AS churn_category,
  COUNT(c.customer_id) AS count_of_churn_cust,
  CONCAT(round(
    100 * COUNT(c.customer_id) / sum(COUNT(c.customer_id)) OVER (), 
    2), ' %') AS churn_pct
FROM Telecom_cust_churn.customer_churn c
JOIN Telecom_cust_churn.customer cu # join to get Churn Category
  ON c.customer_id = cu.customer_id
WHERE c.customer_status = 'Churned'
GROUP BY churn_category
