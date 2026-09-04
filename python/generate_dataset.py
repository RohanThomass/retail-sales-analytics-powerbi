import pandas as pd
import numpy as np
from pathlib import Path


# ============================================================
# 1. SETTINGS
# ============================================================

np.random.seed(42)

NUM_ORDERS = 12000
START_DATE = "2024-01-01"
END_DATE = "2025-12-31"

OUTPUT_DIR = Path(__file__).resolve().parents[1] / "data"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


# ============================================================
# 2. MASTER DATA
# ============================================================

# -------------------------
# Customers
# -------------------------

customers = pd.DataFrame({
    "customer_id": [f"CUST{str(i).zfill(5)}" for i in range(1, 2501)],
    "customer_name": [f"Customer {i}" for i in range(1, 2501)],
    "gender": np.random.choice(
        ["Male", "Female", "Other"],
        size=2500,
        p=[0.48, 0.49, 0.03]
    ),
    "city": np.random.choice(
        [
            "Bengaluru",
            "Chennai",
            "Hyderabad",
            "Mumbai",
            "Delhi",
            "Pune",
            "Kolkata",
            "Ahmedabad"
        ],
        size=2500
    )
})


# -------------------------
# Categories
# -------------------------

categories = [
    "Electronics",
    "Home & Kitchen",
    "Clothing",
    "Beauty",
    "Sports",
    "Grocery"
]


# -------------------------
# Products
# -------------------------

product_names = [
    # Electronics
    "Wireless Headphones",
    "Bluetooth Speaker",
    "Smartphone",
    "Laptop",
    "Smart Watch",
    "USB-C Charger",
    "Power Bank",
    "Wireless Mouse",

    # Home & Kitchen
    "Air Fryer",
    "Mixer Grinder",
    "Electric Kettle",
    "Coffee Maker",
    "Dinner Set",
    "Bedsheet Set",
    "Storage Box",
    "Water Bottle",

    # Clothing
    "Men's T-Shirt",
    "Women's T-Shirt",
    "Jeans",
    "Hoodie",
    "Formal Shirt",
    "Kurta",
    "Sports Shoes",
    "Casual Shoes",

    # Beauty
    "Face Wash",
    "Moisturizer",
    "Shampoo",
    "Perfume",
    "Lipstick",
    "Sunscreen",
    "Hair Serum",
    "Body Lotion",

    # Sports
    "Yoga Mat",
    "Cricket Bat",
    "Football",
    "Badminton Racket",
    "Dumbbells",
    "Skipping Rope",
    "Gym Gloves",
    "Resistance Bands",

    # Grocery
    "Rice 5kg",
    "Wheat Flour 5kg",
    "Cooking Oil",
    "Tea",
    "Coffee",
    "Biscuits",
    "Breakfast Cereal",
    "Dry Fruits"
]

product_category = (
    ["Electronics"] * 8
    + ["Home & Kitchen"] * 8
    + ["Clothing"] * 8
    + ["Beauty"] * 8
    + ["Sports"] * 8
    + ["Grocery"] * 8
)

products = pd.DataFrame({
    "product_id": [f"PROD{str(i).zfill(4)}" for i in range(1, 49)],
    "product_name": product_names,
    "category": product_category
})


# -------------------------
# Product pricing
# -------------------------

price_ranges = {
    "Electronics": (800, 80000),
    "Home & Kitchen": (300, 15000),
    "Clothing": (500, 5000),
    "Beauty": (200, 5000),
    "Sports": (300, 7000),
    "Grocery": (100, 2500)
}

prices = []

for category in products["category"]:
    low, high = price_ranges[category]
    price = np.random.uniform(low, high)
    prices.append(round(price, 2))

products["unit_price"] = prices


# -------------------------
# Stores
# -------------------------

stores = pd.DataFrame({
    "store_id": [
        "ST001",
        "ST002",
        "ST003",
        "ST004",
        "ST005",
        "ST006",
        "ST007",
        "ST008"
    ],
    "store_name": [
        "Bengaluru Central",
        "Chennai Central",
        "Hyderabad Central",
        "Mumbai Central",
        "Delhi Central",
        "Pune Central",
        "Kolkata Central",
        "Ahmedabad Central"
    ],
    "city": [
        "Bengaluru",
        "Chennai",
        "Hyderabad",
        "Mumbai",
        "Delhi",
        "Pune",
        "Kolkata",
        "Ahmedabad"
    ]
})


# ============================================================
# 3. GENERATE ORDERS
# ============================================================

dates = pd.date_range(
    start=START_DATE,
    end=END_DATE,
    freq="D"
)

order_dates = np.random.choice(
    dates,
    size=NUM_ORDERS
)

orders = pd.DataFrame({
    "order_id": [
        f"ORD{str(i).zfill(6)}"
        for i in range(1, NUM_ORDERS + 1)
    ],
    "order_date": order_dates,
    "customer_id": np.random.choice(
        customers["customer_id"],
        size=NUM_ORDERS
    ),
    "store_id": np.random.choice(
        stores["store_id"],
        size=NUM_ORDERS,
        p=[0.18, 0.12, 0.14, 0.16, 0.15, 0.10, 0.07, 0.08]
    ),
    "product_id": np.random.choice(
        products["product_id"],
        size=NUM_ORDERS
    ),
    "quantity": np.random.choice(
        [1, 2, 3, 4, 5],
        size=NUM_ORDERS,
        p=[0.45, 0.28, 0.15, 0.08, 0.04]
    )
})


# ============================================================
# 4. MERGE PRODUCT INFORMATION
# ============================================================

orders = orders.merge(
    products[
        [
            "product_id",
            "product_name",
            "category",
            "unit_price"
        ]
    ],
    on="product_id",
    how="left"
)


# ============================================================
# 5. GENERATE DISCOUNTS
# ============================================================

orders["discount"] = np.random.choice(
    [0, 0.05, 0.10, 0.15, 0.20, 0.25],
    size=NUM_ORDERS,
    p=[0.25, 0.20, 0.25, 0.15, 0.10, 0.05]
)


# ============================================================
# 6. CALCULATE REVENUE
# ============================================================

orders["gross_sales"] = (
    orders["quantity"]
    * orders["unit_price"]
)

orders["discount_amount"] = (
    orders["gross_sales"]
    * orders["discount"]
)

orders["revenue"] = (
    orders["gross_sales"]
    - orders["discount_amount"]
)


# ============================================================
# 7. GENERATE COST AND PROFIT
# ============================================================

# Different categories have different typical margins.
margin_ranges = {
    "Electronics": (0.08, 0.22),
    "Home & Kitchen": (0.15, 0.30),
    "Clothing": (0.30, 0.55),
    "Beauty": (0.35, 0.60),
    "Sports": (0.25, 0.45),
    "Grocery": (0.08, 0.20)
}

cost_values = []

for _, row in orders.iterrows():

    min_margin, max_margin = margin_ranges[row["category"]]

    margin = np.random.uniform(
        min_margin,
        max_margin
    )

    cost = row["revenue"] * (1 - margin)

    cost_values.append(round(cost, 2))


orders["cost"] = cost_values

orders["profit"] = (
    orders["revenue"]
    - orders["cost"]
)


# ============================================================
# 8. ADD PAYMENT METHOD
# ============================================================

orders["payment_method"] = np.random.choice(
    [
        "UPI",
        "Credit Card",
        "Debit Card",
        "Cash",
        "Net Banking"
    ],
    size=NUM_ORDERS,
    p=[0.38, 0.25, 0.20, 0.07, 0.10]
)


# ============================================================
# 9. ADD CUSTOMER SEGMENT
# ============================================================

customer_segment = np.random.choice(
    [
        "Regular",
        "Premium",
        "Occasional"
    ],
    size=NUM_ORDERS,
    p=[0.60, 0.15, 0.25]
)

orders["customer_segment"] = customer_segment


# ============================================================
# 10. FORMAT DATES
# ============================================================

orders["order_date"] = pd.to_datetime(
    orders["order_date"]
).dt.strftime("%Y-%m-%d")


# ============================================================
# 11. SELECT FINAL COLUMNS
# ============================================================

final_columns = [
    "order_id",
    "order_date",
    "customer_id",
    "customer_segment",
    "store_id",
    "product_id",
    "product_name",
    "category",
    "quantity",
    "unit_price",
    "discount",
    "gross_sales",
    "discount_amount",
    "revenue",
    "cost",
    "profit",
    "payment_method"
]

orders = orders[final_columns]


# ============================================================
# 12. INTRODUCE A FEW DATA-QUALITY ISSUES
# ============================================================

# Missing customer ID
missing_customer_rows = np.random.choice(
    orders.index,
    size=20,
    replace=False
)

orders.loc[
    missing_customer_rows,
    "customer_id"
] = np.nan


# Missing payment method
missing_payment_rows = np.random.choice(
    orders.index,
    size=15,
    replace=False
)

orders.loc[
    missing_payment_rows,
    "payment_method"
] = np.nan


# A few zero quantities
zero_quantity_rows = np.random.choice(
    orders.index,
    size=5,
    replace=False
)

orders.loc[
    zero_quantity_rows,
    "quantity"
] = 0


# Recalculate affected financial fields
orders["gross_sales"] = (
    orders["quantity"]
    * orders["unit_price"]
)

orders["discount_amount"] = (
    orders["gross_sales"]
    * orders["discount"]
)

orders["revenue"] = (
    orders["gross_sales"]
    - orders["discount_amount"]
)

orders["profit"] = (
    orders["revenue"]
    - orders["cost"]
)


# ============================================================
# 13. SAVE DATASET
# ============================================================

output_file = OUTPUT_DIR / "retail_sales.csv"

orders.to_csv(
    output_file,
    index=False
)


# ============================================================
# 14. BASIC VALIDATION
# ============================================================

print("=" * 60)
print("RETAIL SALES DATASET GENERATED")
print("=" * 60)

print(f"Rows: {len(orders):,}")
print(f"Columns: {len(orders.columns)}")
print(f"Output: {output_file}")

print("\nDate range:")
print(
    orders["order_date"].min(),
    "to",
    orders["order_date"].max()
)

print("\nMissing values:")
print(
    orders.isna().sum()
)

print("\nCategories:")
print(
    orders["category"].value_counts()
)

print("\nStores:")
print(
    orders["store_id"].value_counts()
)

print("\nFinancial summary:")
print(
    orders[
        [
            "gross_sales",
            "discount_amount",
            "revenue",
            "cost",
            "profit"
        ]
    ].sum()
)

print("\nFirst 5 rows:")
print(
    orders.head()
)

print("=" * 60)