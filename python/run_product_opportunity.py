import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / "data" / "retail_sales.db"
SQL_PATH = BASE_DIR / "sql" / "07_join_validation.sql"

with sqlite3.connect(DB_PATH) as conn:
    with open(SQL_PATH, "r", encoding="utf-8") as file:
        sql_script = file.read()

    statements = [
        statement.strip()
        for statement in sql_script.split(";")
        if statement.strip()
    ]

    for i, statement in enumerate(statements, start=1):
        print("=" * 80)
        print(f"CHECK {i}")
        print("=" * 80)

        cursor = conn.execute(statement)

        columns = [description[0] for description in cursor.description]
        print(" | ".join(columns))
        print("-" * 80)

        for row in cursor.fetchall():
            print(" | ".join(str(value) for value in row))