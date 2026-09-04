-- Customers
DROP TABLE IF EXISTS customers;

CREATE TABLE customers AS
WITH segment_counts AS (
    SELECT
        customer_id,
        customer_segment,
        COUNT(*) AS segment_count
    FROM retail_sales
    WHERE customer_id IS NOT NULL
    GROUP BY
        customer_id,
        customer_segment
),
ranked_segments AS (
    SELECT
        customer_id,
        customer_segment,
        segment_count,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY segment_count DESC, customer_segment
        ) AS rn
    FROM segment_counts
)
SELECT
    customer_id,
    customer_segment
FROM ranked_segments
WHERE rn = 1;