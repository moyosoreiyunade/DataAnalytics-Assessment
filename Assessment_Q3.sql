-- Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days).

SELECT a.id AS plan_id, a.owner_id, CASE 
										 WHEN a.is_a_fund = 1 THEN 'Investments'
										 WHEN a.is_regular_savings = 1 THEN 'Savings'
										 ELSE 'N/A' 
									END AS type, -- When is_a_fund equals 1, return Investments. When is_regular_savings equals 1, return Savings
	   MAX(b.transaction_date) AS last_transaction_date, DATEDIFF(CURDATE(), MAX(b.transaction_date)) as inactivity_days -- duration in days between current date and the last_transaction_date
FROM adashi_staging.plans_plan a
LEFT JOIN adashi_staging.savings_savingsaccount b
ON a.id = b.plan_id
WHERE a.is_a_fund = 1 OR a.is_regular_savings = 1 -- filter rows to accounts in either savings or investment plans
GROUP BY a.owner_id, a.id
HAVING MAX(b.transaction_date) < DATE_SUB(CURDATE(), INTERVAL 365 DAY) -- last_transaction_date over a year (365 days) ago