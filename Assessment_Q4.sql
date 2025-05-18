-- For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest

SELECT customer_id, name, tenure_months, total_transactions, 
		ROUND(((total_transactions/tenure_months)*12*avg_profit_per_transaction),2) AS estimated_clv
FROM (-- diffrence in months between signup date and current date
		SELECT a.id AS customer_id, CONCAT(a.first_name, ' ', a.last_name) AS name, 
				SUM(TIMESTAMPDIFF(MONTH, a.created_on, CURDATE())) AS tenure_months, COUNT(owner_id) AS total_transactions, 
				AVG(amount*0.001) AS avg_profit_per_transaction
		FROM adashi_staging.users_customuser a
		LEFT JOIN adashi_staging.savings_savingsaccount b -- join all records in the customer demographic table
		ON a.id = b.owner_id
		GROUP BY a.id, name
        ) AS Query1
ORDER BY estimated_clv DESC