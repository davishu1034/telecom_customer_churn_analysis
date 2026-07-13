--Total Number of customer in Q2--
SELECT
  COUNT(DISTINCT customer_id) Total_customer
FROM Telecom_cust_churn.customer;

--Customer distribution % by customer_status-- 
SELECT
  customer_status,
  COUNT(customer_id) AS cnt_cust,
  CONCAT(ROUND(
      100 * COUNT(customer_id)/SUM(COUNT(customer_id)) OVER (),#count(cust_id)shows No of cust per status & sum(count)shows total customer
      2),'%') AS pct_cust
FROM `Telecom_cust_churn.customer`
GROUP BY customer_status
