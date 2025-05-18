# DATA ANALYTICS ASSESSMENT (COWRYWISE)

## 1. Question: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
### Approach:
- I created a Common Table Expression named funded_plans that filters out plans with amount > 0, indicating they are funded. Then, using sums on the is_regular_savings and is_a_fund columns, I calculated the number of savings and investment plans per customer.
- I created a second CTE, named customer_deposits, which aggregates the confirmed_amount from the deposit transactions table for each customer.
- I joined both CTEs with the customer demographic table. I then filtered only those customers who have at least one funded savings plan and one funded investment plan, and sorted the result by total deposits in descending order.

### Challenges:
- At first, I didn't know what columns was used for the savings and investment plans. I was able to resolve this by reading through the document provided where i was able to confirm in the Hints section (is_regular_savings and is_a_fund).

  

## 2. Question: Calculate the average number of transactions per customer per month and categorize them: "High Frequency" (≥10 transactions/month), "Medium Frequency" (3-9 transactions/month), "Low Frequency" (≤2 transactions/month)
### Approach:
- For CTE 1, I computed the total number of transactions per customer per month.
- For CTE 2, I averaged the monthly transactions across months for each customer.
- For CTE 3, I used a CASE statement to assign customers to frequency categories (High, Medium, Low) and return "uncategorized" if average values is greater than 2, but less than 3, and also if average values is greater than 9 but less than 10.
- Finally, I aggregated the number of customers in each category and calculated their respective average.

### Challenges:
- There were some average values which didn't fall in any of the 3 categories requested for (that is, average values that are greater than 2, but less than 3 and average values that are greater than 9, but less than 10). I was able to resolve this by stating that if any average value doesn't fall into any of the 3 given categories, return as "Uncategorized".


## 3. Question: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)
### Approach:
- I queried the plans_plan table to identify all active accounts that are either savings (is_regular_savings = 1) or investment plans (is_a_fund = 1) using a CASE statement, to clearly label each account as a "Savings" or "Investment" account.
- I used a LEFT JOIN with the savings_savingsaccount table to bring in all related transactions, ensuring that accounts with no transaction history at all are still included to fufill the objective.
- I used GROUP BY on both owner_id and plan_id to track each account separately.
- I used MAX(b.transaction_date) to get the latest transaction per plan and calculated the inactivity in days using DATEDIFF.
- I filtered the results using a HAVING clause to only include accounts with no transactions in the last 365 days.

### Challenges:
- I initially used an INNER JOIN, which excluded plans that had never recorded any transaction. I resolved this by switching to a LEFT JOIN to ensure those inactive plans were still included.


## 4. Question: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate: Account tenure (months since signup), Total transactions, Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction), and Order by estimated CLV from highest to lowest

### Approach:
- I joined users_customuser and savings_savingsaccount on owner_id to link customer data to transaction history.
- I computed tenure using TIMESTAMPDIFF(MONTH, created_on, CURDATE()) and calculated total transactions for each customer.
- I computed average profit per transaction by multiplying each transaction amount by 0.001 and taking the average.
- I used the subquery to calculate estimated_clv using the formula provided, and rounded it to 2 decimal places for clarity.
- I Sorted the results by estimated_clv in descending order to show high-value customers first.

### Challenges:
- I initially used an INNER JOIN, which excluded plans that had never recorded any transaction. I resolved this by switching to a LEFT JOIN to ensure those inactive plans were still included.
