--Total Revenue--
SELECT
  CONCAT(ROUND(
  SUM(total_revenue)/1000000,
  2), ' Million') AS total_revenue
From Telecom_cust_churn.payment;

-- Total Revenue loss by churn customer -- 
SELECT 
  customer_status,
  COUNT(c.customer_id) AS count_of_churn_cust,
  CONCAT(ROUND(
  SUM(p.total_revenue)/1000000,
  2), ' Million') AS total_revenue_loss
FROM Telecom_cust_churn.customer_churn c
JOIN Telecom_cust_churn.payment p #join to get revenue from payment table
  ON c.customer_id = p.customer_id
WHERE customer_status = 'Churned'
GROUP BY customer_status;

--Total revenue loss % by churn customer--
SELECT
  CONCAT(ROUND(
      SUM(p.total_revenue) / 1000000,2), ' Million')AS total_revenue,
  CONCAT(ROUND(
      SUM(
        CASE 
          WHEN c.customer_status = 'Churned' THEN p.total_revenue ELSE 0 
        END)/ 1000000,2),' Million') AS revenue_loss, # Case to filter out only Churn customer Revenue
  CONCAT(ROUND(
      100* SUM(
          CASE
            WHEN c.customer_status = 'Churned' THEN p.total_revenue ELSE 0
          END)/ SUM(p.total_revenue),2),' %') AS revenue_loss_pct
FROM `Telecom_cust_churn.customer_churn` c
JOIN `Telecom_cust_churn.payment` p #join to get revenue from payment table
  ON p.customer_id = c.customer_id;

-- Revenue loss distribution between churn category -- 
SELECT 
  churn_category,
  COUNT(c.customer_id) AS count_of_churn_cust,
  CONCAT(ROUND(
  100 * COUNT(c.customer_id) / SUM(COUNT(c.customer_id)) OVER (), 
  2), ' %') AS churn_pct,
  CONCAT(ROUND(
  SUM(p.total_revenue)/1000000,
  2), ' Million') AS total_revenue_loss
FROM Telecom_cust_churn.customer_churn c
JOIN Telecom_cust_churn.payment p  #join to get revenue from payment table
  ON c.customer_id = p.customer_id
WHERE customer_status = 'Churned'
GROUP BY churn_category
ORDER BY count_of_churn_cust DESC