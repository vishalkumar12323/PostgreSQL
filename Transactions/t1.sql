-- Active: 1783355328541@@127.0.0.1@5432@postgres
select version() as pgadmin_version;

-- A database transaction is a single unit of work that execute a series of operations (ex. reading or updating data)
-- as an "all or nothing" block.

-- Create the sample Accounts table.
CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    balance DECIMAL(10, 2) CHECK(balance >= 0)
);

-- Insert Sample Data.
INSERT INTO
    accounts (
        account_id,
        customer_name,
        balance
    )
VALUES (
        1,
        'Alice (Account A)',
        500.00
    ),
    (2, 'Bob (Account B)', 150.00);

SELECT * FROM public.accounts;

-- Execute Transfer Transaction with Error Handling.
DO $$ 
BEGIN 
    RAISE NOTICE 'Starting transfer...';

-- Deduct $100 from Alice (Account 1)
    UPDATE accounts SET balance = balance - 100.00  
    WHERE account_id = 1;

-- Add $100 to Bob (Account 2)
    UPDATE accounts SET balance = balance + 100.00
    WHERE account_id = 2;

    RAISE NOTICE 'Transfer successful! Committing changes...';

EXCEPTION WHEN OTHERS THEN 
    RAISE WARNING 'An error occured! Rolling back transaction. Error: %',SQLERRM;

END $$;

SELECT * FROM accounts;