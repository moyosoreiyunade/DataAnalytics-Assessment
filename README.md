# DATA ANALYTICS ASSESSMENT

# 1. Question: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
# Approach:
- I created a Common Table Expression named funded_plans that filters out plans with amount > 0, indicating they are funded. Then, using sums on the is_regular_savings and is_a_fund columns, I calculated the number of savings and investment plans per customer.
- I created a second CTE, named customer_deposits, which aggregates the confirmed_amount from the deposit transactions table for each customer.
- I joined both CTEs with the customer demographic table. I then filtered only those customers who have at least one funded savings plan and one funded investment plan, and sorted the result by total deposits in descending order.

# Challenges:
- At first, I didn't know what columns was used for the savings and investment plans. I was able to resolve this by reading through the document provided where i was able to confirm in the Hints section (is_regular_savings and is_a_fund).
