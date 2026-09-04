import sqlite3
from pathlib import Path
import pandas as pd

BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / "data" / "retail_sales.db"
OUTPUT_PATH = BASE_DIR / "excel" / "retail_sales_analysis.xlsx"

query = """
SELECT
    order_id,
    order_date,
    customer_id,
    customer_segment,
    store_id,
    product_id,
    product_name,
    category,
    quantity,
    unit_price,
    discount,
    gross_sales,
    discount_amount,
    revenue,
    cost,
    profit,
    payment_method
FROM retail_sales
WHERE quantity > 0
ORDER BY order_date, order_id;
"""
with sqlite3.connect(DB_PATH) as conn:
    df = pd.read_sql_query(query, conn)

df["order_date"] = pd.to_datetime(df["order_date"])

with pd.ExcelWriter(OUTPUT_PATH, engine="openpyxl") as writer:
    df.to_excel(writer, sheet_name="Raw_Data", index=False)

print(f"Excel file created: {OUTPUT_PATH}")
print(f"Rows exported: {len(df)}")
print(f"Columns exported: {len(df.columns)}")