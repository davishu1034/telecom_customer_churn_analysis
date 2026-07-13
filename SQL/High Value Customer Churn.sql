WITH Base AS 
(SELECT
  COUNT(c.customer_id) as total_high_value_customer,
  COUNTIF(customer_status='Churned') high_value_churn_customer,
  CONCAT(ROUND(
    SUM(CASE
          WHEN customer_status = 'Churned' # Case to filter out only Churn customer Revenue
        THEN total_revenue ELSE 0 END) / 1000000, 
        2), ' Million') AS revenue_lost
FROM `Telecom_cust_churn.customer` c
JOIN `Telecom_cust_churn.payment` p #join to get Revenue and Monthly charges from payment table
  ON p.customer_id = c.customer_id
WHERE  monthly_charge > (SELECT
                           ROUND(AVG(monthly_charge), 2) AS avg_monthly_charge 
                        FROM `Telecom_cust_churn.payment` p 
                        WHERE p.monthly_charge >= 0)  #sub_query to find out average montly_charges
AND  tenure_in_months > (SELECT
                           ROUND(AVG(tenure_in_months), 2) AS avg_tenure 
                       FROM `Telecom_cust_churn.customer`c)  #sub_query to find out average Tenure
)
SELECT
  total_high_value_customer,
  high_value_churn_customer,
  CONCAT(ROUND(100*high_value_churn_customer/total_high_value_customer,2),' %') AS churn_rate,
  revenue_lost
FROM Base