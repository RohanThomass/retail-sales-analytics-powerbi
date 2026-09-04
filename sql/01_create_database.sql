-- ============================================================
-- RETAIL SALES ANALYTICS
-- STEP 2: DATABASE SETUP
-- ============================================================

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    order_id TEXT,
    order_date DATE,
    customer_id TEXT,
    customer_segment TEXT,
    store_id TEXT,
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    quantity INTEGER,
    unit_price REAL,
    discount REAL,
    gross_sales REAL,
    discount_amount REAL,
    revenue REAL,
    cost REAL,
    profit REAL,
    payment_method TEXT
);