WITH Base AS (
  SELECT
    COUNT(streaming_movies) AS cnt_cust,  #total customers for whom this service option exists
    COUNTIF(s.streaming_movies = TRUE) AS subscribed_cust, #customer has subscribed to the service
    COUNTIF(s.streaming_movies = TRUE AND c.customer_status = 'Churned') AS subscribed_churn_cust,
    COUNTIF(s.streaming_movies = FALSE) AS not_subscribed_cust,  #customer has not subscribed to the service
    COUNTIF(s.streaming_movies = FALSE AND c.customer_status = 'Churned') AS not_subscribed_churn_cust
  FROM Telecom_cust_churn.customer c
  JOIN Telecom_cust_churn.services s # join to get different service from service table
    ON c.customer_id = s.customer_id
)
SELECT
  cnt_cust,
  subscribed_cust,
  subscribed_churn_cust,
  CONCAT(ROUND(100 * subscribed_churn_cust / subscribed_cust, 2),' %') AS churn_rate_subscribed_cust,
  not_subscribed_cust,
  not_subscribed_churn_cust,
  CONCAT(ROUND(100 * not_subscribed_churn_cust / not_subscribed_cust, 2),' %') AS churn_rate_not_subscribed_cust
FROM Base;