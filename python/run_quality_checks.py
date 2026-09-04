import sqlite3
from pathlib import Path


# ------------------------------------------------------------
# File locations
# ------------------------------------------------------------

PROJECT_DIR = Path(__file__).resolve().parents[1]

DATABASE_FILE = PROJECT_DIR / "data" / "retail_sales.db"
SQL_FILE = PROJECT_DIR / "sql" / "02_data_quality_checks.sql"


# ------------------------------------------------------------
# Read SQL file
# ------------------------------------------------------------

with open(SQL_FILE, "r", encoding="utf-8") as file:
    sql_script = file.read()


# ------------------------------------------------------------
# Connect to database
# ------------------------------------------------------------

connection = sqlite3.connect(DATABASE_FILE)


# ------------------------------------------------------------
# Split SQL script into individual statements
# ------------------------------------------------------------

statements = [
    statement.strip()
    for statement in sql_script.split(";")
    if statement.strip()
]


# ------------------------------------------------------------
# Execute each query
# ------------------------------------------------------------

for number, statement in enumerate(statements, start=1):

    print("\n" + "=" * 70)
    print(f"CHECK {number}")
    print("=" * 70)

    try:
        cursor = connection.execute(statement)

        # SELECT statements return rows
        if cursor.description:

            columns = [
                column[0]
                for column in cursor.description
            ]

            rows = cursor.fetchall()

            print(" | ".join(columns))

            for row in rows:
                print(" | ".join(str(value) for value in row))

        else:
            print("Statement executed successfully.")

    except Exception as error:
        print(f"ERROR: {error}")


connection.close()

print("\n" + "=" * 70)
print("QUALITY CHECKS COMPLETE")
print("=" * 70)