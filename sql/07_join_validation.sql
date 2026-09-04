-- ============================================================
-- STEP 3E: JOIN VALIDATION
-- ============================================================

-- Check 1: Transactions with valid customer matches
SELECT
    COUNT(*) AS total_valid_transactions,
    COUNT(c.customer_id) AS matched_customers,
    COUNT(*) - COUNT(c.customer_id) AS unmatched_customers
FROM retail_sales r
LEFT JOIN customers c
    ON r.customer_id = c.customer_id
WHERE r.quantity > 0;


-- Check 2: Transactions with valid product matches
SELECT
    COUNT(*) AS total_valid_transactions,
    COUNT(p.product_id) AS matched_products,
    COUNT(*) - COUNT(p.product_id) AS unmatched_products
FROM retail_sales r
LEFT JOIN products p
    ON r.product_id = p.product_id
WHERE r.quantity > 0;


-- Check 3: Transactions with valid store matches
SELECT
    COUNT(*) AS total_valid_transactions,
    COUNT(s.store_id) AS matched_stores,
    COUNT(*) - COUNT(s.store_id) AS unmatched_stores
FROM retail_sales r
LEFT JOIN stores s
    ON r.store_id = s.store_id
WHERE r.quantity > 0;