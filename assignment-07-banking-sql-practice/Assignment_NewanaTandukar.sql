-- Assignment: Banking SQL Practice
-- Run schema.sql then load.sql first

-- 1. Show every ACTIVE account together with the full name and email of the owning customer.
SELECT a.account_id, a.account_type, a.branch, a.balance, a.status,
       c.first_name || ' ' || c.last_name AS full_name, c.email
FROM accounts a
JOIN customers c ON c.customer_id = a.customer_id
WHERE a.status = 'Active';


-- 2. Find every customer who currently has NO account at all.
SELECT c.*
FROM customers c
LEFT JOIN accounts a ON a.customer_id = c.customer_id
WHERE a.account_id IS NULL;


-- 3. Find every account whose customer_id does not match any row in customers (orphaned accounts).
SELECT a.*
FROM accounts a
LEFT JOIN customers c ON c.customer_id = a.customer_id
WHERE c.customer_id IS NULL;


-- 4. Every customer and every account regardless of match, labeled Matched/No Account/Missing Customer.
SELECT c.customer_id, a.account_id,
       CASE
           WHEN c.customer_id IS NOT NULL AND a.account_id IS NOT NULL THEN 'Matched'
           WHEN c.customer_id IS NOT NULL AND a.account_id IS NULL THEN 'No Account'
           ELSE 'Missing Customer'
       END AS match_status
FROM customers c
FULL OUTER JOIN accounts a ON a.customer_id = c.customer_id;


-- 5. Transaction id, amount, account type, branch and the full name of the owning customer (three-table join).
SELECT t.transaction_id, t.amount, a.account_type, a.branch,
       c.first_name || ' ' || c.last_name AS customer_name
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
JOIN customers c ON c.customer_id = a.customer_id;


-- 6. Total balance held at each branch, highest to lowest.
SELECT branch, SUM(balance) AS total_balance
FROM accounts
GROUP BY branch
ORDER BY total_balance DESC;


-- 7. TOP 5 branches by total balance, Active accounts only.
SELECT branch, SUM(balance) AS total_balance
FROM accounts
WHERE status = 'Active'
GROUP BY branch
ORDER BY total_balance DESC
LIMIT 5;


-- 8. Account types where the average balance exceeds 50,000, rounded to 2 decimals.
SELECT account_type, ROUND(AVG(balance), 2) AS avg_balance
FROM accounts
GROUP BY account_type
HAVING AVG(balance) > 50000;


-- 9. Count accounts per customer, only customers holding more than 1 account.
SELECT customer_id, COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 10. Branch/account_type combination with the single highest total transaction amount.
SELECT a.branch, a.account_type, SUM(t.amount) AS total_amount
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
GROUP BY a.branch, a.account_type
ORDER BY total_amount DESC
LIMIT 1;


-- 11. Customers whose combined account balance is greater than the overall average balance.
SELECT c.customer_id, c.first_name, c.last_name, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(a.balance) > (SELECT AVG(balance) FROM accounts);


-- 12. Accounts whose balance is above the average balance of their own account_type (correlated subquery).
SELECT a.*
FROM accounts a
WHERE a.balance > (
    SELECT AVG(a2.balance) FROM accounts a2 WHERE a2.account_type = a.account_type
);


-- 13. EXISTS: customers who have made at least one 'Withdrawal' transaction.
SELECT c.*
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM accounts a
    JOIN transactions t ON t.account_id = a.account_id
    WHERE a.customer_id = c.customer_id AND t.txn_type = 'Withdrawal'
);


-- 14. NOT EXISTS: accounts that have never had a single transaction.
SELECT a.*
FROM accounts a
WHERE NOT EXISTS (
    SELECT 1 FROM transactions t WHERE t.account_id = a.account_id
);


-- 15. IN with a subquery: customers who live in a city that has more than 3 customers.
SELECT *
FROM customers
WHERE city IN (
    SELECT city FROM customers GROUP BY city HAVING COUNT(*) > 3
);


-- 16. Subquery in FROM (inline view): accounts and avg balance per branch, keep branches with more than 5 accounts.
SELECT branch_summary.branch, branch_summary.account_count, branch_summary.avg_balance
FROM (
    SELECT branch, COUNT(*) AS account_count, AVG(balance) AS avg_balance
    FROM accounts
    GROUP BY branch
) branch_summary
WHERE branch_summary.account_count > 5;


-- 17. UNION: customer ids holding Savings OR Checking, de-duplicated.
SELECT customer_id FROM accounts WHERE account_type = 'Savings'
UNION
SELECT customer_id FROM accounts WHERE account_type = 'Checking';


-- 18. UNION ALL: same list but keeping duplicates.
SELECT customer_id FROM accounts WHERE account_type = 'Savings'
UNION ALL
SELECT customer_id FROM accounts WHERE account_type = 'Checking';


-- 19. INTERSECT: customer ids that appear in BOTH the Savings list and the Checking list.
SELECT customer_id FROM accounts WHERE account_type = 'Savings'
INTERSECT
SELECT customer_id FROM accounts WHERE account_type = 'Checking';


-- 20. EXCEPT: customer ids with a Savings account but NOT a Fixed Deposit account.
SELECT customer_id FROM accounts WHERE account_type = 'Savings'
EXCEPT
SELECT customer_id FROM accounts WHERE account_type = 'Fixed Deposit';


-- 21. CTE: total transaction amount for each account, keep accounts whose total exceeds 100,000.
WITH account_totals AS (
    SELECT account_id, SUM(amount) AS total_amount
    FROM transactions
    GROUP BY account_id
)
SELECT a.*, act.total_amount
FROM accounts a
JOIN account_totals act ON act.account_id = a.account_id
WHERE act.total_amount > 100000;


-- 22. CTE: single highest-balance account in EACH branch.
WITH ranked_accounts AS (
    SELECT a.*, RANK() OVER (PARTITION BY branch ORDER BY balance DESC) AS balance_rank
    FROM accounts a
)
SELECT *
FROM ranked_accounts
WHERE balance_rank = 1;


-- 23. Two chained CTEs: total Deposit txns per account, then accounts whose total deposits exceed current balance.
WITH deposit_totals AS (
    SELECT account_id, SUM(amount) AS total_deposits
    FROM transactions
    WHERE txn_type = 'Deposit'
    GROUP BY account_id
),
account_vs_deposits AS (
    SELECT a.account_id, a.balance, dt.total_deposits
    FROM accounts a
    JOIN deposit_totals dt ON dt.account_id = a.account_id
)
SELECT *
FROM account_vs_deposits
WHERE total_deposits > balance;


-- 24. VIEW exposing only Active accounts with the full name of the owning customer.
DROP VIEW IF EXISTS active_accounts_view;
CREATE VIEW active_accounts_view AS
SELECT a.*, c.first_name || ' ' || c.last_name AS customer_name
FROM accounts a
JOIN customers c ON c.customer_id = a.customer_id
WHERE a.status = 'Active';


-- 25. MATERIALIZED VIEW pre-aggregating total balance and account count per branch, refreshed CONCURRENTLY.
DROP MATERIALIZED VIEW IF EXISTS branch_balance_summary;
CREATE MATERIALIZED VIEW branch_balance_summary AS
SELECT branch, SUM(balance) AS total_balance, COUNT(*) AS account_count
FROM accounts
GROUP BY branch;

-- CONCURRENTLY needs a unique index to identify rows.
CREATE UNIQUE INDEX branch_balance_summary_branch_idx ON branch_balance_summary(branch);

REFRESH MATERIALIZED VIEW CONCURRENTLY branch_balance_summary;


-- 26. ROW_NUMBER(): only the MOST RECENT transaction for every account.
WITH ranked_txns AS (
    SELECT t.*, ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY txn_date DESC, txn_time DESC) AS rn
    FROM transactions t
)
SELECT *
FROM ranked_txns
WHERE rn = 1;


-- 27. RANK(): rank customers by total account balance, tied balances share a rank with a gap afterward.
SELECT c.customer_id, c.first_name, c.last_name, SUM(a.balance) AS total_balance,
       RANK() OVER (ORDER BY SUM(a.balance) DESC) AS balance_rank
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


-- 28. DENSE_RANK(): rank branches by total transaction amount with NO gaps.
SELECT a.branch, SUM(t.amount) AS total_amount,
       DENSE_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS branch_rank
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
GROUP BY a.branch;


-- 29. LAG(): each transaction next to the amount of the PREVIOUS transaction on the same account.
SELECT t.*,
       LAG(amount) OVER (PARTITION BY account_id ORDER BY txn_date, txn_time) AS prev_amount
FROM transactions t;


-- 30. LEAD(): each transaction next to the amount of the NEXT transaction, with the difference between them.
SELECT t.*,
       LEAD(amount) OVER (PARTITION BY account_id ORDER BY txn_date, txn_time) AS next_amount,
       LEAD(amount) OVER (PARTITION BY account_id ORDER BY txn_date, txn_time) - amount AS amount_diff
FROM transactions t;


-- 31. Running-total window function: the transactions of every account in date order with a cumulative amount.
SELECT t.*,
       SUM(amount) OVER (
           PARTITION BY account_id
           ORDER BY txn_date, txn_time
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM transactions t;


-- 32. Duplicate customer records: same first_name, last_name and dob.
SELECT first_name, last_name, dob, COUNT(*) AS duplicate_count, ARRAY_AGG(customer_id) AS customer_ids
FROM customers
GROUP BY first_name, last_name, dob
HAVING COUNT(*) > 1;


-- 33a. Customers missing a city or email (NULL or blank).
SELECT *
FROM customers
WHERE city IS NULL OR TRIM(city) = '' OR email IS NULL OR TRIM(email) = '';

-- 33b. Orphaned accounts (customer_id with no matching customer row).
SELECT a.*
FROM accounts a
LEFT JOIN customers c ON c.customer_id = a.customer_id
WHERE c.customer_id IS NULL;


-- 34. CASE WHEN: bucket every Active account into Low/Medium/High, then count accounts in each bucket.
SELECT
    CASE
        WHEN balance < 10000 THEN 'Low'
        WHEN balance BETWEEN 10000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS balance_bucket,
    COUNT(*) AS account_count
FROM accounts
WHERE status = 'Active'
GROUP BY balance_bucket;


-- 35. Safe transaction block: 500 maintenance fee on every account with balance > 200,000,
--     plus a matching 'Fee' row in transactions for each of those accounts.
BEGIN;

CREATE TEMPORARY TABLE fee_accounts AS
SELECT account_id, balance AS balance_before, currency
FROM accounts
WHERE balance > 200000;

UPDATE accounts
SET balance = balance - 500
WHERE account_id IN (SELECT account_id FROM fee_accounts);

INSERT INTO transactions (
    transaction_id, account_id, txn_date, txn_time, txn_type, channel,
    amount, currency, balance_after, merchant, description, is_flagged
)
SELECT
    (SELECT COALESCE(MAX(transaction_id), 0) FROM transactions) + ROW_NUMBER() OVER (ORDER BY account_id),
    account_id, CURRENT_DATE, CURRENT_TIME, 'Fee', 'Branch',
    500, currency, balance_before - 500, NULL, 'Monthly maintenance fee', FALSE
FROM fee_accounts;

DROP TABLE fee_accounts;

-- Inspect the results, then either:
COMMIT;
-- or, if anything looks wrong: ROLLBACK;


-- 36. NTILE(4): split customers into 4 equal-sized income quartiles, count customers per quartile.
WITH income_quartiles AS (
    SELECT customer_id, annual_income, NTILE(4) OVER (ORDER BY annual_income) AS quartile
    FROM customers
)
SELECT quartile, COUNT(*) AS customer_count
FROM income_quartiles
GROUP BY quartile
ORDER BY quartile;


-- 37. Customers with credit_score below 500 who still hold an account with balance above 200,000.
SELECT DISTINCT c.*
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
WHERE c.credit_score < 500 AND a.balance > 200000;


-- 38. Every FLAGGED transaction with the name of the owning customer, branch and channel, ordered by amount desc.
SELECT t.transaction_id, t.amount, t.channel, a.branch,
       c.first_name || ' ' || c.last_name AS customer_name
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
JOIN customers c ON c.customer_id = a.customer_id
WHERE t.is_flagged = TRUE
ORDER BY t.amount DESC;


-- 39. Customers whose kyc_status is 'Expired' but who still have at least one 'Active' account.
SELECT DISTINCT c.*
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
WHERE c.kyc_status = 'Expired' AND a.status = 'Active';


-- 40. Joint accounts whose balance is above the average balance of all accounts in their own branch.
SELECT a.*
FROM accounts a
WHERE a.is_joint_account = TRUE
  AND a.balance > (
      SELECT AVG(a2.balance) FROM accounts a2 WHERE a2.branch = a.branch
  );
