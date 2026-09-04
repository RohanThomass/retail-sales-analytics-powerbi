import sqlite3
from pathlib import Path


PROJECT_DIR = Path(__file__).resolve().parents[1]
DATABASE_FILE = PROJECT_DIR / "data" / "retail_sales.db"


connection = sqlite3.connect(DATABASE_FILE)

query = """
SELECT *
FROM retail_sales
LIMIT 5;
"""

cursor = connection.execute(query)

for row in cursor.fetchall():
    print(row)

connection.close()