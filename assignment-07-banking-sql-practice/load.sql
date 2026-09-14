-- Assignment: Banking SQL Practice — data load
-- Run schema.sql first. Run this with psql from the assignment-07-banking-sql-practice
-- directory (relative CSV paths), e.g.:
--   psql -h localhost -U <user> -d banking_db -f load.sql

\copy customers FROM 'data/customers.csv' WITH (FORMAT csv, HEADER true, NULL '');
\copy accounts FROM 'data/accounts.csv' WITH (FORMAT csv, HEADER true, NULL '');
\copy transactions FROM 'data/transactions.csv' WITH (FORMAT csv, HEADER true, NULL '');

-- Add the FK back now that the data (including the orphaned account 100280,
-- customer_id 99999) is loaded. NOT VALID skips checking existing rows but still
-- enforces the constraint on any future insert/update.
ALTER TABLE accounts
    ADD CONSTRAINT accounts_customer_id_fkey
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) NOT VALID;
