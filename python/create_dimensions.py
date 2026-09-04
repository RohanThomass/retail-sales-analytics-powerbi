import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / "data" / "retail_sales.db"
SQL_PATH = BASE_DIR / "sql" / "04_create_dimensions.sql"

with sqlite3.connect(DB_PATH) as conn:
    with open(SQL_PATH, "r", encoding="utf-8") as file:
        sql_script = file.read()

    conn.executescript(sql_script)

print("Dimension tables created successfully.")