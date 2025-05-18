--  Calculate the average number of transactions per customer per month and categorize them:
-- "High Frequency" (≥10 transactions/month)
-- "Medium Frequency" (3-9 transactions/month)
-- "Low Frequency" (≤2 transactions/month)

SELECT frequency_category, COUNT(DISTINCT id) AS customer_count, ROUND(AVG(average_transactions),2) AS avg_transactions_per_month
FROM (
		SELECT id, month, ROUND(AVG(number_of_transactions),2) AS average_transactions, 
					CASE WHEN AVG(number_of_transactions) >= 10 THEN 'High Frequency'
							WHEN AVG(number_of_transactions) BETWEEN 3 AND 9 THEN 'Medium Frequency'
							WHEN AVG(number_of_transactions) <=2 THEN 'Low Frequency'
					ELSE 'Error' END AS frequency_category
		FROM (
				SELECT a.id, MONTHNAME(b.transaction_date) AS month, COUNT(b.id) AS number_of_transactions
				FROM adashi_staging.users_customuser a
				JOIN adashi_staging.savings_savingsaccount b
				ON a.id = b.owner_id
				GROUP BY a.id, MONTHNAME(b.transaction_date)
				) AS number_of_transactions_per_cust_per_month
		GROUP BY id, month
        ) AS categorized
GROUP BY frequency_category
ORDER BY avg_transactions_per_month DESC