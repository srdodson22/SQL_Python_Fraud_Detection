-- view table 
PRAGMA table_info(dirty_transactions);

-- trim extra whitespaces
UPDATE dirty_transactions
SET
	transaction_id = TRIM(transaction_id),
	customer_id = TRIM(customer_id),
	country = TRIM(country),
	merchant = TRIM(merchant),
	channel = TRIM(channel);
	
-- standardize capitalization
UPDATE dirty_transactions
SET
	country = LOWER(country),
	merchant = LOWER(merchant),
	channel = LOWER(channel);
	
-- remove possible duplicates
DELETE FROM dirty_transactions
WHERE rowid NOT IN (
	SELECT MIN(rowid)
	FROM dirty_transactions
	GROUP BY transaction_id
);

-- convert data format
SELECT transaction_id,
	CASE
		WHEN date LIKE '%/%' THEN
		substr(date, 7, 4) || '-' ||
		substr(date, 1, 2) || '-' ||
		substr(date, 4, 2)
	  ELSE
		date
	END AS date
FROM dirty_transactions;

-- handle nulls
UPDATE dirty_transactions
SET
	merchant = 'not recorded'
WHERE merchant IS NULL;

UPDATE dirty_transactions
SET
	channel = 'not recorded'
WHERE channel IS NULL;

-- convert amount to numeric 
UPDATE dirty_transactions
SET 
	amount_usd = REPLACE(amount_usd, '$', ' ');

-- show transactions with invalid customer IDs
SELECT *
FROM dirty_transactions
WHERE customer_id NOT IN (
	SELECT customer_id FROM dirty_customers
);

-- save as new table 
CREATE TABLE clean_transactions AS
SELECT * FROM dirty_transactions;