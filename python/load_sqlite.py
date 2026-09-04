import sqlite3
from pathlib import Path

import pandas as pd


# ------------------------------------------------------------
# File locations
# ------------------------------------------------------------

PROJECT_DIR = Path(__file__).resolve().parents[1]

CSV_FILE = PROJECT_DIR / "data" / "retail_sales.csv"
DATABASE_FILE = PROJECT_DIR / "data" / "retail_sales.db"


# ------------------------------------------------------------
# Load CSV
# ------------------------------------------------------------

df = pd.read_csv(CSV_FILE)


# ------------------------------------------------------------
# Connect to SQLite
# ------------------------------------------------------------

connection = sqlite3.connect(DATABASE_FILE)


# ------------------------------------------------------------
# Load data into SQLite
# ------------------------------------------------------------

df.to_sql(
    "retail_sales",
    connection,
    if_exists="replace",
    index=False
)


# ------------------------------------------------------------
# Basic verification
# ------------------------------------------------------------

cursor = connection.cursor()

cursor.execute(
    "SELECT COUNT(*) FROM retail_sales"
)

row_count = cursor.fetchone()[0]

cursor.execute(
    "SELECT COUNT(*) FROM retail_sales WHERE quantity = 0"
)

zero_quantity_count = cursor.fetchone()[0]


print("=" * 60)
print("SQLITE DATABASE CREATED")
print("=" * 60)

print(f"Database: {DATABASE_FILE}")
print(f"Rows loaded: {row_count:,}")
print(f"Zero quantity rows: {zero_quantity_count}")

print("=" * 60)


connection.close()