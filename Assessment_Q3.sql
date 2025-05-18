-- Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days).

SELECT a.id AS plan_id, a.owner_id, CASE WHEN a.is_a_fund = 1 THEN 'Savings'
										 WHEN a.is_regular_savings = 1 THEN 'Investments'
										 ELSE 'N/A' END AS type,
	   MAX(b.transaction_date) AS last_transaction_date, DATEDIFF(CURDATE(), MAX(b.transaction_date)) as inactivity_days
FROM adashi_staging.plans_plan a
JOIN adashi_staging.savings_savingsaccount b
ON a.id = b.plan_id
WHERE a.is_a_fund = 1 OR a.is_regular_savings = 1
GROUP BY owner_id, plan_id
HAVING MAX(transaction_date) < CURDATE() - INTERVAL 365 DAY