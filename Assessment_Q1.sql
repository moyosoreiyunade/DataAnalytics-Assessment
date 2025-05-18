--  Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits 

WITH funded_plans AS (
						SELECT owner_id, SUM(is_regular_savings) AS savings_count, SUM(is_a_fund) AS investment_count
						FROM adashi_staging.plans_plan
						WHERE amount > 0 -- Only funded plans
                        GROUP BY owner_id
                        ),
                        
	customer_deposits AS (
							SELECT owner_id, SUM(confirmed_amount) AS total_deposits
							FROM adashi_staging.savings_savingsaccount
							GROUP BY owner_id
							)

SELECT a.id AS owner_id, CONCAT(a.first_name, ' ', a.last_name) AS name, b.savings_count,
		b.investment_count, ROUND(c.total_deposits, 2) AS total_deposits
FROM adashi_staging.users_customuser a
JOIN funded_plans b
ON a.id = b.owner_id
JOIN customer_deposits c
ON a.id = c.owner_id
WHERE b.savings_count >= 1 AND b.investment_count >= 1
ORDER BY total_deposits DESC;