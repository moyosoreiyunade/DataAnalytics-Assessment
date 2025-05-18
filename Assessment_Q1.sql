--  Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits 

WITH funded_plans AS (
						SELECT owner_id, amount, is_regular_savings, is_a_fund
						FROM adashi_staging.plans_plan
                        WHERE amount > 0 -- account funded should not be empty 
                        )

SELECT c.owner_id, CONCAT(a.first_name, ' ', a.last_name) AS name, -- combine first and last name
		SUM(c.is_regular_savings) AS savings_count, SUM(c.is_a_fund) AS investment_count,
        ROUND(SUM(b.confirmed_amount),2) AS total_deposits 
FROM adashi_staging.users_customuser a
JOIN adashi_staging.savings_savingsaccount b
ON a.id = b.owner_id
JOIN funded_plans c
ON a.id = c.owner_id
GROUP BY a.id
HAVING savings_count >= 1  AND investment_count = 1 -- at least one funded savings plan, and one investment plan
ORDER BY total_deposits DESC