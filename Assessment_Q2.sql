-- Calculate the average number of transactions per customer per month and categorize them.

-- CTE 1: Calculate total number of transactions each customer makes per month 
WITH transactions_per_customer_month AS (
						SELECT owner_id, MONTHNAME(transaction_date) AS month, 
							COUNT(id) AS transactions_in_month
						FROM adashi_staging.savings_savingsaccount
						GROUP BY owner_id, MONTHNAME(transaction_date)
						),

-- CTE 2: Get the average number of monthly transactions per customer
	average_transactions_per_customer AS (
						SELECT owner_id, AVG(transactions_in_month) AS avg_transactions
						FROM transactions_per_customer_month
						GROUP BY owner_id
						),

-- CTE 3: Categorize each customer based on their average number of monthly transactions
	categorized_customers AS (
					SELECT owner_id, avg_transactions,
							CASE 
								WHEN avg_transactions >= 10 THEN 'High Frequency'
								WHEN avg_transactions BETWEEN 3 AND 9 THEN 'Medium Frequency'
								WHEN avg_transactions <= 2 THEN 'Low Frequency'
								ELSE 'Uncategorized' -- Average values which doesn't fall under the 3 conditions (values greater than 2, and less than 3. Also values greater than 9, and less than 10) will fall under "uncategorized"
							END AS frequency_category
					FROM average_transactions_per_customer
					)

-- Finally, aggregate by frequency_category to get the number of customers and their average transactions
SELECT frequency_category, COUNT(owner_id) AS customer_count, 
		ROUND(AVG(avg_transactions), 2) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY avg_transactions_per_month DESC;
