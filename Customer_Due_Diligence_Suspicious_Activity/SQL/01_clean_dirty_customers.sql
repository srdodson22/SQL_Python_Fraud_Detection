-- view table info
PRAGMA table_info(dirty_customers);

-- trim extra whitespaces
UPDATE dirty_customers
SET 
	customer_id = TRIM(customer_id),
	name = TRIM(name),
	country = TRIM(country),
	kyc_status = TRIM(kyc_status),
	customer_type = TRIM(customer_type);

-- standardize capitalizatino
UPDATE dirty_customers
SET 
	name = LOWER(name),
	country = LOWER(country),
	occupation = LOWER(occupation),
	kyc_status = LOWER(kyc_status),
	customer_type = LOWER(customer_type);

-- remove duplicates
DELETE FROM dirty_customers
WHERE rowid NOT IN (
	SELECT MIN(rowid)
	FROM dirty_customers
	GROUP BY customer_id
);

-- convert date formats
SELECT customer_id,
	CASE
		WHEN account_open_date LIKE '%/%' THEN
			substr(account_open_date, 7, 4) || '-' ||
			substr(account_open_date, 1, 2) || '-' ||
			substr(account_open_date, 4, 2)
		ELSE
			account_open_date
		END AS account_open_date
	FROM dirty_customers;

SELECT customer_id,
	CASE
		WHEN dob LIKE '%/%' THEN
			substr(dob, 7, 4) || '-' ||
			substr(dob, 1, 2) || '-' ||
			substr(dob, 4, 2)
		ELSE
			dob
		END AS dob
	FROM dirty_customers;
	
-- handled nulls
UPDATE dirty_customers
SET 
	dob = NULL
WHERE dob IS NULL;

UPDATE dirty_customers
SET 
	occupation = 'not provided'
WHERE occupation IS NULL;

UPDATE dirty_customers
SET 
	kyc_status = 'pending'
WHERE kyc_status IS NULL;

-- create clean version 
CREATE TABLE clean_customers AS
SELECT * FROM dirty_customers;

-- testing new table 
SELECT country, count(*) 
FROM clean_customers 
GROUP BY country;