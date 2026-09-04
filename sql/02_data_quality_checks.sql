-- ============================================================
-- RETAIL SALES ANALYTICS
-- STEP 2: DATA QUALITY CHECKS
-- ============================================================


-- ============================================================
-- CHECK 1: TOTAL ROW COUNT
-- ============================================================

SELECT
    COUNT(*) AS total_rows
FROM retail_sales;


-- ============================================================
-- CHECK 2: DUPLICATE ORDER IDS
-- ============================================================

SELECT
    order_id,
    COUNT(*) AS row_count
FROM retail_sales
GROUP BY order_id
HAVING COUNT(*) > 1;


-- ============================================================
-- CHECK 3: MISSING CUSTOMER IDS
-- ============================================================

SELECT
    COUNT(*) AS missing_customer_ids
FROM retail_sales
WHERE customer_id IS NULL
   OR TRIM(customer_id) = '';


-- ============================================================
-- CHECK 4: MISSING PAYMENT METHODS
-- ============================================================

SELECT
    COUNT(*) AS missing_payment_methods
FROM retail_sales
WHERE payment_method IS NULL
   OR TRIM(payment_method) = '';


-- ============================================================
-- CHECK 5: INVALID QUANTITY
-- ============================================================

SELECT
    COUNT(*) AS invalid_quantity_rows
FROM retail_sales
WHERE quantity <= 0;


-- ============================================================
-- CHECK 6: INVALID DISCOUNTS
-- ============================================================

SELECT
    COUNT(*) AS invalid_discount_rows
FROM retail_sales
WHERE discount < 0
   OR discount > 1;


-- ============================================================
-- CHECK 7: INVALID UNIT PRICES
-- ============================================================

SELECT
    COUNT(*) AS invalid_unit_price_rows
FROM retail_sales
WHERE unit_price <= 0;


-- ============================================================
-- CHECK 8: INVALID REVENUE
-- ============================================================

SELECT
    COUNT(*) AS invalid_revenue_rows
FROM retail_sales
WHERE revenue < 0;


-- ============================================================
-- CHECK 9: INVALID PROFIT
-- ============================================================

SELECT
    COUNT(*) AS invalid_profit_rows
FROM retail_sales
WHERE profit > revenue;


-- ============================================================
-- CHECK 10: REVENUE CALCULATION CHECK
-- ============================================================

SELECT
    COUNT(*) AS incorrect_revenue_calculations
FROM retail_sales
WHERE ABS(
    revenue
    - (
        quantity * unit_price
        - discount_amount
      )
) > 0.01;


-- ============================================================
-- CHECK 11: PROFIT CALCULATION CHECK
-- ============================================================

SELECT
    COUNT(*) AS incorrect_profit_calculations
FROM retail_sales
WHERE ABS(
    profit - (revenue - cost)
) > 0.01;


-- ============================================================
-- CHECK 12: DISTINCT CATEGORIES
-- ============================================================

SELECT DISTINCT
    category
FROM retail_sales
ORDER BY category;


-- ============================================================
-- CHECK 13: DISTINCT STORES
-- ============================================================

SELECT DISTINCT
    store_id
FROM retail_sales
ORDER BY store_id;


-- ============================================================
-- CHECK 14: DISTINCT PAYMENT METHODS
-- ============================================================

SELECT DISTINCT
    payment_method
FROM retail_sales
WHERE payment_method IS NOT NULL
ORDER BY payment_method;


-- ============================================================
-- CHECK 15: DATE RANGE
-- ============================================================

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM retail_sales;


-- ============================================================
-- CHECK 16: BASIC FINANCIAL SUMMARY
-- ============================================================

SELECT
    ROUND(SUM(gross_sales), 2) AS gross_sales,
    ROUND(SUM(discount_amount), 2) AS discounts,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(cost), 2) AS cost,
    ROUND(SUM(profit), 2) AS profit
FROM retail_sales;