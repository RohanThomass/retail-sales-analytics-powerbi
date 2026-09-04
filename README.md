# Retail Sales Analytics & Power BI Dashboard

## 📊 Project Overview

An end-to-end retail sales analytics project built to demonstrate practical skills in SQL, Python/Pandas, Excel, and Power BI.

The project analyzes 12,000+ retail sales records across products, categories, stores, customers, and time periods to identify revenue, profitability, customer, and product performance trends.

> **Note:** The dataset is synthetically generated for portfolio and demonstration purposes.

---

## 🛠️ Tools & Technologies

- **SQL / SQLite** — data validation, joins, aggregations, CTEs, window functions
- **Python / Pandas** — data generation, transformation, validation, and analysis
- **Microsoft Excel** — PivotTables and business analysis
- **Power BI** — interactive sales and profitability dashboard
- **GitHub** — project version control and documentation

---

## 📁 Project Structure

```text
Retail-Sales-Analytics/
│
├── README.md
├── data/
│   └── retail_sales.csv
│
├── python/
│   ├── generate_dataset.py
│   ├── load_sqlite.py
│   ├── run_quality_checks.py
│   ├── run_sql_analysis.py
│   ├── create_dimensions.py
│   └── run_product_opportunity.py
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_business_analysis.sql
│   ├── 04_create_dimensions.sql
│   ├── 05_join_analysis.sql
│   ├── 06_product_opportunity.sql
│   └── 07_join_validation.sql
│
├── excel/
│   ├── retail_sales_analysis.xlsx
│   └── data_quality_log.xlsx
│
├── powerbi/
│   └── Retail_Sales_Analytics_Dashboard.pbix
│
└── screenshots/
    └── dashboard.png
