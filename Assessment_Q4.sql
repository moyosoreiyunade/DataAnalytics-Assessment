-- For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest

SELECT customer_id, name, tenure_months, total_transactions, 
	ROUND(((total_transactions/tenure_months) * 12 * avg_profit_per_transaction), 2) AS estimated_clv
FROM (
	SELECT a.id AS customer_id, CONCAT(a.first_name, ' ', a.last_name) AS name, 
		TIMESTAMPDIFF(MONTH, a.created_on, CURDATE()) AS tenure_months, -- months since signup
		COUNT(b.id) AS total_transactions, -- Total number of transactions 
		AVG(amount * 0.001) AS avg_profit_per_transaction -- 0.1% of transaction value
	FROM adashi_staging.users_customuser a
	LEFT JOIN adashi_staging.savings_savingsaccount b
	ON a.id = b.owner_id
	GROUP BY a.id, name, tenure_months
        ) AS Query1
ORDER BY estimated_clv DESC
