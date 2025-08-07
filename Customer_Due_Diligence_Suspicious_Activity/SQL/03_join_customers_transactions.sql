CREATE TABLE customer_transaction_sanctions AS
SELECT 
    c.*,
    t.transaction_id,
    t.date,
    t.amount_usd,
    t.country AS transaction_country,
    t.merchant,
    t.channel,
    s.risk_level
FROM clean_customers AS c
LEFT JOIN clean_transactions AS t 
    ON c.customer_id = t.customer_id
LEFT JOIN sanctions_list AS s 
    ON LOWER(TRIM(c.name)) = LOWER(TRIM(s.name));
