


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
````

---

## 🔍 Data Quality Checks

The project includes validation for:

* Duplicate order IDs
* Missing customer IDs
* Missing payment methods
* Invalid quantities
* Invalid discounts
* Invalid unit prices
* Revenue calculation consistency
* Profit calculation consistency
* Date range validation

Business KPIs exclude zero-quantity transactions while the raw dataset is preserved for quality analysis.

---

## 📈 Key Business KPIs

| KPI                 |   Result |
| ------------------- | -------: |
| Valid Transactions  |   11,995 |
| Unique Customers    |    2,480 |
| Units Sold          |   23,863 |
| Revenue             | ₹207.76M |
| Profit              |  ₹42.03M |
| Profit Margin       |   20.23% |
| Average Order Value |  ₹17.32K |
| Basket Size         |     1.99 |

---

## 💡 Key Insights

### 1. Electronics drives revenue

Electronics generated approximately **69.6% of total revenue**, making it the dominant sales category.

However, its **14.9% profit margin** is below the overall business margin of 20.23%.

### 2. High-revenue, low-margin products require attention

Several Electronics products generate substantial revenue but operate at relatively low margins.

The **Bluetooth Speaker** represents a particularly important opportunity for pricing, discount, or procurement optimization.

### 3. Beauty has strong profitability

Beauty generated a **47.6% profit margin**, significantly above the overall business margin.

This suggests an opportunity to examine successful pricing and product economics within the category.

### 4. Store performance varies

ST001 generated the highest revenue and profit, while ST003 achieved the highest profit margin.

This highlights the importance of evaluating both **sales volume and profitability**, rather than ranking stores only by revenue.

### 5. Customer and product performance can be monitored over time

The Power BI dashboard provides monthly revenue trends and interactive filtering by year, category, store, and customer segment.

---

## 📊 Power BI Dashboard

The Power BI dashboard provides an executive view of:

* Total Revenue
* Total Profit
* Profit Margin
* Average Order Value
* Monthly Revenue Trends
* Revenue by Category
* Profit Margin by Category
* Revenue by Store
* Revenue by Customer Segment

Interactive filters allow users to explore performance by:

* Year
* Category
* Store
* Customer Segment

---

## 🧠 SQL Analysis

SQL analysis includes practical retail analytics techniques such as:

* Filtering and aggregation
* GROUP BY analysis
* INNER and LEFT JOINs
* CTEs
* Window functions
* Product ranking
* Category performance analysis
* Store performance analysis
* Monthly sales trends
* Data quality validation

---

## 🐍 Python Analysis

Python/Pandas is used for:

* Synthetic retail dataset generation
* Data validation
* SQLite database loading
* SQL analysis execution
* Dimension creation
* Product opportunity analysis

---

## 📊 Excel Analysis

The Excel workbook contains PivotTable-based analysis for:

* Category performance
* Store performance
* Monthly trends
* Customer segments
* Product performance
* Payment methods
* Data quality

---

## 🎯 Business Objective

The project simulates the type of analysis that can support retail teams with:

* KPI reporting
* Sales performance monitoring
* Pricing analysis
* Product and category evaluation
* Store performance analysis
* Customer segmentation
* Data quality monitoring
* Merchandising decisions

---

## 👤 Author

**[Your Name]**

Data Analytics | SQL | Python | Excel | Power BI

```

Then click **Commit changes**.

### After that

Your GitHub project will have the core structure recruiters expect:

**Code → Data → SQL → Excel → Documentation**

Then we'll add the **dashboard screenshot**, followed by the **PBIX**, and finally make the Power BI dashboard publicly accessible.

Tell me **"README done"** when you've committed it.
```
