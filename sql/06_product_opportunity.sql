-- ============================================================
-- STEP 3D: PRODUCT OPPORTUNITY ANALYSIS
-- ============================================================
WITH product_metrics AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(r.quantity) AS units_sold,
        SUM(r.revenue) AS sales,
        SUM(r.profit) AS profit,
        SUM(r.profit) * 100.0 /
            NULLIF(SUM(r.revenue), 0) AS profit_margin_pct
    FROM retail_sales r
    JOIN products p
        ON r.product_id = p.product_id
    WHERE r.quantity > 0
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
),

benchmarks AS (
    SELECT
        AVG(sales) AS avg_product_sales,
        AVG(profit_margin_pct) AS avg_product_margin
    FROM product_metrics
)

SELECT
    pm.product_id,
    pm.product_name,
    pm.category,
    pm.units_sold,
    ROUND(pm.sales, 2) AS sales,
    ROUND(pm.profit, 2) AS profit,
    ROUND(pm.profit_margin_pct, 2) AS profit_margin_pct,
    ROUND(b.avg_product_sales, 2) AS avg_product_sales,
    ROUND(b.avg_product_margin, 2) AS avg_product_margin
FROM product_metrics pm
CROSS JOIN benchmarks b
WHERE pm.sales > b.avg_product_sales
  AND pm.profit_margin_pct < b.avg_product_margin
ORDER BY pm.sales DESC;