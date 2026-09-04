-- ============================================================
-- STEP 3C: SQL JOIN ANALYSIS
-- ============================================================

-- 1. Sales by customer segment
SELECT
    c.customer_segment,
    COUNT(DISTINCT r.order_id) AS orders,
    COUNT(DISTINCT r.customer_id) AS customers,
    SUM(r.quantity) AS units_sold,
    ROUND(SUM(r.revenue), 2) AS sales,
    ROUND(SUM(r.profit), 2) AS profit,
    ROUND(
        SUM(r.profit) * 100.0 / NULLIF(SUM(r.revenue), 0),
        2
    ) AS profit_margin_pct
FROM retail_sales r
JOIN customers c
    ON r.customer_id = c.customer_id
WHERE r.quantity > 0
GROUP BY c.customer_segment
ORDER BY sales DESC;


-- 2. Sales by product category
SELECT
    p.category,
    COUNT(DISTINCT r.order_id) AS orders,
    SUM(r.quantity) AS units_sold,
    ROUND(SUM(r.revenue), 2) AS sales,
    ROUND(SUM(r.profit), 2) AS profit
FROM retail_sales r
JOIN products p
    ON r.product_id = p.product_id
WHERE r.quantity > 0
GROUP BY p.category
ORDER BY sales DESC;


-- 3. Store performance using store dimension
SELECT
    s.store_id,
    COUNT(DISTINCT r.order_id) AS orders,
    ROUND(SUM(r.revenue), 2) AS sales,
    ROUND(SUM(r.profit), 2) AS profit,
    ROUND(
        SUM(r.profit) * 100.0 / NULLIF(SUM(r.revenue), 0),
        2
    ) AS profit_margin_pct
FROM retail_sales r
JOIN stores s
    ON r.store_id = s.store_id
WHERE r.quantity > 0
GROUP BY s.store_id
ORDER BY sales DESC;