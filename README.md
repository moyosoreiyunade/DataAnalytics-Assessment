# DATA ANALYTICS ASSESSMENT (COWRYWISE)

# 1. Question: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
# Approach:
- I created a Common Table Expression named funded_plans that filters out plans with amount > 0, indicating they are funded. Then, using sums on the is_regular_savings and is_a_fund columns, I calculated the number of savings and investment plans per customer.
- I created a second CTE, named customer_deposits, which aggregates the confirmed_amount from the deposit transactions table for each customer.
- I joined both CTEs with the customer demographic table. I then filtered only those customers who have at least one funded savings plan and one funded investment plan, and sorted the result by total deposits in descending order.

# Challenges:
- At first, I didn't know what columns was used for the savings and investment plans. I was able to resolve this by reading through the document provided where i was able to confirm in the Hints section (is_regular_savings and is_a_fund).


# 2. Question: Calculate the average number of transactions per customer per month and categorize them: "High Frequency" (≥10 transactions/month), "Medium Frequency" (3-9 transactions/month), "Low Frequency" (≤2 transactions/month)
# Approach:
- For CTE 1, I computed the total number of transactions per customer per month.
- For CTE 2, I averaged the monthly transactions across months for each customer.
- For CTE 3, I used a CASE statement to assign customers to frequency categories (High, Medium, Low) and return "uncategorized" if average values is greater than 2, but less than 3, and also if average values is greater than 9 but less than 10.
- Finally, I aggregated the number of customers in each category and calculated their respective average.

# Challenges:
- There were some average values which didn't fall in any of the 3 categories requested for (that is, average values that are greater than 2, but less than 3 and average values that are greater than 9, but less than 10). I was able to resolve this by stating that if any average value doesn't fall into any of the 3 given categories, return as "Uncategorized".
