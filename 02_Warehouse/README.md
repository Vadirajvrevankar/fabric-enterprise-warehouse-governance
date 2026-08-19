# 🏢 02 — Data Warehouse

## Overview

This module implements the **Data Warehouse layer** of the Fabric Enterprise Data Engineering project.

The objective is to take data available through the Fabric Mirrored Database, load it into a controlled staging layer, move it into the analytical Warehouse layer, validate the data, and expose business-friendly analytical views and queries.

---

## 🏗️ Architecture

```text
Azure SQL Database
        │
        ▼
Fabric Mirrored Database
        │
        ▼
     Staging
        │
        ▼
    Warehouse
        │
        ▼
 Analytical Views
        │
        ▼
 Business Analysis
```

### Project objects

```text
EnterpriseWarehouse
│
├── staging
│   ├── Customers
│   ├── Products
│   └── Orders
│
└── warehouse
    ├── Customers
    ├── Products
    ├── Orders
    └── vw_SalesDetails
```

---

## 🎯 Objectives

- Understand the purpose of a Data Warehouse
- Create a Fabric Warehouse
- Separate staging and warehouse layers
- Load data from the Fabric Mirrored Database
- Validate staging and warehouse data
- Create analytical views
- Perform business-oriented SQL analysis
- Apply basic data-quality checks
- Follow practical Warehouse best practices
- Document the implementation in Git

---

## 📚 Concepts Covered

### Data Warehouse

A Data Warehouse is a centralized analytical data store designed for reporting, analytics, historical analysis, and business intelligence.

### OLTP vs OLAP

```text
OLTP → Run the business
OLAP → Analyze the business
```

The source/OLTP database is commonly optimized for transactional efficiency and normalization, while the Warehouse is optimized for analytical workloads.

### Source vs Warehouse

```text
Source / OLTP
→ Transactional efficiency
→ 3NF normalization is common
→ INSERT / UPDATE / DELETE

Warehouse / OLAP
→ Analytical efficiency
→ Dimensional structures are common
→ Reporting / aggregation
```

> Star Schema, Fact Tables, Dimension Tables, SCD, and other dimensional modeling concepts are covered separately in `03_Data_Modeling`.

---

## 🛠️ Practical Implementation

### 1. Create Warehouse

Created:

```text
EnterpriseWarehouse
```

### 2. Create schemas

```text
staging
warehouse
```

### 3. Create staging tables

```text
staging.Customers
staging.Products
staging.Orders
```

### 4. Load data into staging

Data was loaded from:

```text
ECommerceDB_Mirror
```

into:

```text
EnterpriseWarehouse.staging
```

Current data volumes validated during the project:

```text
Customers → 13
Products  → 3
Orders    → 3
```

### 5. Create warehouse tables

```text
warehouse.Customers
warehouse.Products
warehouse.Orders
```

### 6. Load warehouse tables

```text
staging
   ↓
warehouse
```

The staging and warehouse row counts were validated.

---

## 🔍 Data Validation

### Row-count validation

Validated that the expected records were present in the Warehouse.

```text
Customers → 13
Products  → 3
Orders    → 3
```

### Staging vs Warehouse validation

Validated that the staging and Warehouse row counts matched.

### Relationship/data-quality validation

Checked that every Order references an existing:

```text
CustomerID → warehouse.Customers
ProductID  → warehouse.Products
```

Expected result:

```text
No invalid references
```

---

## 📊 Analytical View

Created:

```text
warehouse.vw_SalesDetails
```

The view combines:

```text
Orders
   +
Customers
   +
Products
```

and exposes:

```text
OrderID
CustomerName
Region
ProductName
Category
OrderDate
Quantity
Amount
```

This provides a reusable business-facing analytical layer.

---

## 📈 Business Analysis

### 1. Customer Sales Analysis

Business question:

> How much total sales did each customer generate?

Uses:

```sql
SUM(Amount)
GROUP BY CustomerName
```

### 2. Product Sales Analysis

Business question:

> Which products generated the highest sales?

Uses:

```sql
SUM(Amount)
SUM(Quantity)
GROUP BY ProductName, Category
```

### 3. Regional Sales Analysis

Business question:

> Which region generates the highest total sales?

Uses:

```sql
SUM(Amount)
COUNT(DISTINCT CustomerName)
GROUP BY Region
```

---

## 🧪 Warehouse Best Practices Applied

### Separate staging and warehouse

```text
Source
  ↓
Staging
  ↓
Warehouse
```

This provides a controlled loading/preparation layer.

### Validate after loading

Successful SQL execution does not automatically guarantee correct data. Row counts and relationship checks are performed.

### Avoid repeated blind inserts

Repeated `INSERT` operations can create duplicate records. Production pipelines should use appropriate incremental loading, deduplication, MERGE/upsert, watermark, or CDC strategies where applicable.

### Use views for reusable business logic

Instead of repeatedly writing complex joins, reusable analytical views can provide a simpler interface for reporting and analysis.

### Document the pipeline

SQL scripts, notes, screenshots, and Git commits provide a reproducible record of the implementation.

---

## 📁 SQL Scripts

```text
sql/
├── 01_Create_Schemas.sql
├── 02_Create_Staging_Tables.sql
├── 03_Load_Customers.sql
├── 04_Load_Products.sql
├── 05_Load_Orders.sql
├── 06_Create_Warehouse_Customers.sql
├── 07_Load_Warehouse_Customers.sql
├── 08_Create_Warehouse_Products.sql
├── 09_Load_Warehouse_Products.sql
├── 10_Create_Warehouse_Orders.sql
├── 11_Load_Warehouse_Orders.sql
├── 12_Validate_Warehouse.sql
├── 13_Create_Sales_Details_View.sql
├── 14_Customer_Sales_Analysis.sql
├── 15_Product_Sales_Analysis.sql
├── 16_Regional_Sales_Analysis.sql
└── 17_Data_Quality_Check.sql
```

---

## 📸 Screenshots

Recommended evidence:

```text
screenshots/
├── 01_Warehouse_Created.png
├── 02_Schemas_Created.png
├── 03_Staging_Tables_Created.png
├── 04_Staging_Data_Loaded.png
├── 05_Warehouse_Tables_and_Data.png
├── 06_Warehouse_Validation.png
├── 07_Sales_Details_View.png
├── 08_Customer_Sales_Analysis.png
├── 09_Product_Sales_Analysis.png
└── 10_Regional_Sales_Analysis.png
```

Screenshots should not contain passwords, access tokens, connection strings, or other secrets.

---

## 🧠 Key Learning

```text
Mirroring
→ Replicate source data

Staging
→ Receive and validate source data

Warehouse
→ Store analytical data

View
→ Provide reusable business logic

SQL Analysis
→ Convert warehouse data into business insights

Data Quality
→ Verify that data is valid and usable
```

---

## 🔄 End-to-End Flow

```text
Azure SQL
    ↓
Fabric Mirroring
    ↓
Fabric Mirrored Database
    ↓
Staging
    ↓
Data Validation
    ↓
Warehouse
    ↓
Warehouse Validation
    ↓
Analytical View
    ↓
Customer / Product / Regional Analysis
```

---

## ✅ Module Status

```text
02 — Data Warehouse

Concepts                    ✅
Fabric Warehouse             ✅
Schemas                      ✅
Staging Layer                ✅
Warehouse Layer              ✅
Data Loading                 ✅
Data Validation              ✅
Analytical View              ✅
Business Analysis            ✅
Data Quality Check           ✅
Best Practices               ✅
Documentation                ✅
```

### Next Module

```text
03 — Data Modeling
```

Topics include:

- Fact Tables
- Dimension Tables
- Grain
- Star Schema
- Snowflake Schema
- Surrogate Keys
- Slowly Changing Dimensions (SCD)

