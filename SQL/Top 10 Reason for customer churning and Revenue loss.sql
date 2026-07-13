-- Top 10 Reason for customer churning --
SELECT
  churn_reason,
  COUNT(customer_id) count_of_cust
FROM Telecom_cust_churn.customer_churn
WHERE customer_status = 'Churned'
GROUP BY churn_reason
ORDER BY count_of_cust DESC
LIMIT 10;

-- Top 10 Reason for Revenue loss --
SELECT
  c.churn_reason AS churn_reason,
  concat(Round(sum(p.total_revenue) / 1000, 2), ' K') AS Revenue_loss
FROM Telecom_cust_churn.customer_churn c
JOIN Telecom_cust_churn.payment p
  ON c.customer_id = p.customer_id
WHERE customer_status = 'Churned'
GROUP BY churn_reason
ORDER BY SUM(p.total_revenue) DESC  # sum of total revenue used because revenue loss column is formated for thousand
LIMIT 10
