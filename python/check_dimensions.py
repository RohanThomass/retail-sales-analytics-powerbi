import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / "data" / "retail_sales.db"

with sqlite3.connect(DB_PATH) as conn:

    # Check customers
    customers_count = conn.execute(
        "SELECT COUNT(*) FROM customers"
    ).fetchone()[0]

    # Check products
    products_count = conn.execute(
        "SELECT COUNT(*) FROM products"
    ).fetchone()[0]

    # Check stores
    stores_count = conn.execute(
        "SELECT COUNT(*) FROM stores"
    ).fetchone()[0]

    print("Dimension table counts:")
    print(f"Customers: {customers_count}")
    print(f"Products: {products_count}")
    print(f"Stores: {stores_count}")

    print("\nSample customers:")
    for row in conn.execute("""
        SELECT *
        FROM customers
        ORDER BY customer_id
        LIMIT 5
    """):
        print(row)

    print("\nSample products:")
    for row in conn.execute("""
        SELECT *
        FROM products
        ORDER BY product_id
        LIMIT 5
    """):
        print(row)

    print("\nStores:")
    for row in conn.execute("""
        SELECT *
        FROM stores
        ORDER BY store_id
    """):
        print(row)