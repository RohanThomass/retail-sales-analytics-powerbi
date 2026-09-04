-- ============================================================
-- RETAIL SALES ANALYTICS
-- STEP 3: BUSINESS ANALYSIS
-- ============================================================


-- ============================================================
-- ANALYSIS 1: OVERALL RETAIL KPIs
-- ============================================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) * 100.0 / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value,
    ROUND(
        SUM(quantity) * 1.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS basket_size
FROM retail_sales
WHERE quantity > 0;


-- ============================================================
-- ANALYSIS 2: CATEGORY PERFORMANCE
-- ============================================================

SELECT
    category,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(
        SUM(profit) * 100.0
        / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct
FROM retail_sales
WHERE quantity > 0
GROUP BY category
ORDER BY sales DESC;


-- ============================================================
-- ANALYSIS 3: PRODUCT PERFORMANCE
-- ============================================================

SELECT
    product_id,
    product_name,
    category,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(
        SUM(profit) * 100.0
        / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct
FROM retail_sales
WHERE quantity > 0
GROUP BY
    product_id,
    product_name,
    category
ORDER BY sales DESC
LIMIT 15;


-- ============================================================
-- ANALYSIS 4: STORE PERFORMANCE
-- ============================================================

SELECT
    store_id,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(
        SUM(profit) * 100.0
        / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct,
    ROUND(
        SUM(revenue)
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM retail_sales
WHERE quantity > 0
GROUP BY store_id
ORDER BY sales DESC;


-- ============================================================
-- ANALYSIS 5: MONTHLY SALES TREND
-- ============================================================

SELECT
    substr(order_date, 1, 7) AS sales_month,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(
        SUM(profit) * 100.0
        / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct
FROM retail_sales
WHERE quantity > 0
GROUP BY substr(order_date, 1, 7)
ORDER BY sales_month;


-- ============================================================
-- ANALYSIS 6: CUSTOMER PERFORMANCE
-- ============================================================

SELECT
    customer_id,
    customer_segment,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS units_purchased,
    ROUND(SUM(revenue), 2) AS customer_sales,
    ROUND(SUM(profit), 2) AS customer_profit,
    ROUND(
        SUM(revenue)
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS customer_aov
FROM retail_sales
WHERE
    quantity > 0
    AND customer_id IS NOT NULL
GROUP BY
    customer_id,
    customer_segment
ORDER BY customer_sales DESC
LIMIT 20;


-- ============================================================
-- ANALYSIS 7: CUSTOMER SEGMENT PERFORMANCE
-- ============================================================

SELECT
    customer_segment,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(
        SUM(profit) * 100.0
        / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct
FROM retail_sales
WHERE
    quantity > 0
    AND customer_id IS NOT NULL
GROUP BY customer_segment
ORDER BY sales DESC;


-- ============================================================
-- ANALYSIS 8: CATEGORY RANKING USING WINDOW FUNCTION
-- ============================================================

WITH category_sales AS (

    SELECT
        category,
        ROUND(SUM(revenue), 2) AS sales
    FROM retail_sales
    WHERE quantity > 0
    GROUP BY category

)

SELECT
    category,
    sales,
    RANK() OVER (
        ORDER BY sales DESC
    ) AS sales_rank
FROM category_sales
ORDER BY sales_rank;


-- ============================================================
-- ANALYSIS 9: PRODUCT RANKING WITHIN CATEGORY
-- ============================================================

WITH product_sales AS (

    SELECT
        product_id,
        product_name,
        category,
        ROUND(SUM(revenue), 2) AS sales
    FROM retail_sales
    WHERE quantity > 0
    GROUP BY
        product_id,
        product_name,
        category

)

SELECT
    product_id,
    product_name,
    category,
    sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY sales DESC
    ) AS category_product_rank
FROM product_sales
ORDER BY
    category,
    category_product_rank;


-- ============================================================
-- ANALYSIS 10: MONTH-OVER-MONTH SALES GROWTH
-- ============================================================

WITH monthly_sales AS (

    SELECT
        substr(order_date, 1, 7) AS sales_month,
        SUM(revenue) AS sales
    FROM retail_sales
    WHERE quantity > 0
    GROUP BY substr(order_date, 1, 7)

),

sales_with_previous_month AS (

    SELECT
        sales_month,
        sales,
        LAG(sales) OVER (
            ORDER BY sales_month
        ) AS previous_month_sales
    FROM monthly_sales

)

SELECT
    sales_month,
    ROUND(sales, 2) AS sales,
    ROUND(previous_month_sales, 2) AS previous_month_sales,
    ROUND(
        (
            sales - previous_month_sales
        ) * 100.0
        / NULLIF(previous_month_sales, 0),
        2
    ) AS mom_growth_pct
FROM sales_with_previous_month
ORDER BY sales_month;


-- ============================================================
-- ANALYSIS 11: TOP 10 CUSTOMERS BY REVENUE
-- ============================================================

WITH customer_sales AS (

    SELECT
        customer_id,
        SUM(revenue) AS sales
    FROM retail_sales
    WHERE
        quantity > 0
        AND customer_id IS NOT NULL
    GROUP BY customer_id

)

SELECT
    customer_id,
    ROUND(sales, 2) AS sales,
    RANK() OVER (
        ORDER BY sales DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank
LIMIT 10;


-- ============================================================
-- ANALYSIS 12: STORE RANKING
-- ============================================================

WITH store_sales AS (

    SELECT
        store_id,
        SUM(revenue) AS sales,
        SUM(profit) AS profit
    FROM retail_sales
    WHERE quantity > 0
    GROUP BY store_id

)

SELECT
    store_id,
    ROUND(sales, 2) AS sales,
    ROUND(profit, 2) AS profit,
    ROUND(
        profit * 100.0
        / NULLIF(sales, 0),
        2
    ) AS profit_margin_pct,
    RANK() OVER (
        ORDER BY sales DESC
    ) AS sales_rank,
    RANK() OVER (
        ORDER BY profit DESC
    ) AS profit_rank
FROM store_sales
ORDER BY sales_rank;


-- ============================================================
-- ANALYSIS 13: HIGH-SALES / LOW-MARGIN PRODUCTS
-- ============================================================

WITH product_metrics AS (

    SELECT
        product_id,
        product_name,
        category,
        SUM(revenue) AS sales,
        SUM(profit) AS profit,
        SUM(profit) * 100.0
            / NULLIF(SUM(revenue), 0) AS margin_pct
    FROM retail_sales
    WHERE quantity > 0
    GROUP BY
        product_id,
        product_name,
        category

)

SELECT
    product_id,
    product_name,
    category,
    ROUND(sales, 2) AS sales,
    ROUND(profit, 2) AS profit,
    ROUND(margin_pct, 2) AS profit_margin_pct
FROM product_metrics
WHERE sales >= (
    SELECT AVG(sales)
    FROM product_metrics
)
AND margin_pct < (
    SELECT AVG(margin_pct)
    FROM product_metrics
)
ORDER BY sales DESC;


-- ============================================================
-- ANALYSIS 14: PAYMENT METHOD PERFORMANCE
-- ============================================================

SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(revenue), 2) AS sales,
    ROUND(
        SUM(revenue)
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM retail_sales
WHERE
    quantity > 0
    AND payment_method IS NOT NULL
GROUP BY payment_method
ORDER BY sales DESC;