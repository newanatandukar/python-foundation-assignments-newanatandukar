-- Assignment: Banking SQL Practice — schema

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id     INTEGER PRIMARY KEY,
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    gender          VARCHAR(10),
    dob             DATE,
    city            VARCHAR(50),
    state           VARCHAR(50),
    country         VARCHAR(50),
    phone           VARCHAR(20),
    email           VARCHAR(100),
    occupation      VARCHAR(50),
    annual_income   NUMERIC(14,2),
    credit_score    INTEGER,
    kyc_status      VARCHAR(20),
    join_date       DATE,
    risk_category   VARCHAR(20)
);

CREATE TABLE accounts (
    account_id        INTEGER PRIMARY KEY,
    customer_id       INTEGER,
    account_type      VARCHAR(30),
    branch            VARCHAR(50),
    ifsc_code         VARCHAR(15),
    currency          VARCHAR(5),
    balance           NUMERIC(14,2),
    interest_rate     NUMERIC(5,2),
    open_date         DATE,
    close_date        DATE,
    status            VARCHAR(20),
    is_joint_account  BOOLEAN
);

CREATE TABLE transactions (
    transaction_id   INTEGER PRIMARY KEY,
    account_id       INTEGER REFERENCES accounts(account_id),
    txn_date         DATE,
    txn_time         TIME,
    txn_type         VARCHAR(30),
    channel          VARCHAR(30),
    amount           NUMERIC(14,2),
    currency         VARCHAR(5),
    balance_after    NUMERIC(14,2),
    merchant         VARCHAR(60),
    description      VARCHAR(100),
    is_flagged       BOOLEAN
);
