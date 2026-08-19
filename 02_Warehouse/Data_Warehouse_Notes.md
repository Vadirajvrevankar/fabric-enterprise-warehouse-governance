# 🏢 02 — Data Warehouse Notes

## 1. What is a Data Warehouse?

A **Data Warehouse** is a centralized analytical data store designed to store structured and historical business data for analytics, reporting, Business Intelligence (BI), and decision making.

> **Easy definition:** A Data Warehouse is a centralized system optimized for analyzing structured and historical business data.

```text
OLTP → Run the business
OLAP → Analyze the business
```

---

## 2. Why Do We Need a Data Warehouse?

Operational databases are mainly designed to run applications and process day-to-day transactions.

Analytical workloads may involve:

- Large amounts of historical data
- Complex joins
- Aggregations
- GROUP BY operations
- Reporting queries
- Business analysis

### Main reasons

- Analyze historical data
- Support reporting
- Support BI tools
- Run complex analytical queries
- Separate analytical workloads from operational workloads
- Provide a consistent analytical data source
- Support business decision-making

---

## 3. When Do We Use a Data Warehouse?

Use a Data Warehouse when:

- SQL-based analytics is required
- Historical data needs to be analyzed
- Business reporting is required
- Large analytical queries are required
- BI tools need an analytical data source
- Data needs to be structured for analytics
- Consistent business reporting is required

### Example business questions

```text
What are total sales this month?
Which product generated the highest revenue?
Which region has the highest sales?
What is the yearly sales trend?
Who are the top customers?
```

---

## 4. OLTP vs OLAP

### OLTP — Online Transaction Processing

OLTP systems run day-to-day business operations.

Examples:

```text
Customer places an order
Payment is processed
Inventory is updated
Customer details are changed
```

Typical operations:

```text
INSERT
UPDATE
DELETE
```

**Focus:** fast transactions, current operational data, data integrity, transaction processing.

### OLAP — Online Analytical Processing

OLAP systems analyze business data.

Examples:

```text
Total sales by region
Monthly revenue
Top-selling products
Year-over-year sales
```

Typical operations:

```text
SELECT
SUM()
COUNT()
AVG()
GROUP BY
JOIN
```

**Focus:** analytics, reporting, historical analysis, aggregations, BI.

### ⭐ Easy memory

```text
OLTP → Run the business
OLAP → Analyze the business
```

---

## 5. Source Database vs Data Warehouse Structure

The source database and Data Warehouse are designed for different purposes.

### Source / OLTP Database

The source database is generally structured for **transactional efficiency**.

It commonly uses **normalization**, such as **3NF (Third Normal Form)**, to reduce unnecessary data duplication and maintain data integrity.

**Focus:**

- Transactional efficiency
- INSERT / UPDATE / DELETE
- Data integrity
- Reduced redundancy
- Operational workloads

### Data Warehouse / OLAP

A Data Warehouse structures data for **analysis and reporting**.

It commonly uses analytical models such as:

- Star Schema
- Snowflake Schema

**Focus:**

- Analytical query performance
- Reporting
- Aggregations
- Historical analysis
- BI workloads

| Source / OLTP | Data Warehouse / OLAP |
|---|---|
| Transactional efficiency | Analytical efficiency |
| Often normalized | Often dimensional/analytical |
| 3NF is common | Star/Snowflake schemas are common |
| Reduce redundancy | Optimize analytical querying |
| Operational data | Historical/analytical data |
| INSERT / UPDATE / DELETE | SELECT / Aggregations |

### 🧠 Easy memory

```text
OLTP
→ Normalize for transactions
→ 3NF

OLAP
→ Structure for analysis
→ Star / Snowflake
```

> The source database is optimized for **running the business**, while the Data Warehouse is optimized for **analyzing the business**.

**Note:** Star Schema, Snowflake Schema, Fact Tables, Dimension Tables, Keys, Relationships and SCD will be covered deeply in `03_Data_Modeling`.

---

## 6. Microsoft Fabric Warehouse

**Microsoft Fabric Warehouse** is a SQL-based analytical data store designed for structured analytical workloads.

Main uses:

- SQL analytics
- Structured data
- Reporting
- Business Intelligence
- Historical analysis
- Analytical workloads

### ⭐ Easy memory

```text
Fabric Warehouse
= SQL + Structured Data + Analytics
```

---

## 7. Warehouse vs Lakehouse

### Lakehouse

Strongly suited for data engineering workloads.

Common technologies:

- Spark
- PySpark
- Spark SQL
- Notebooks
- Delta tables
- Parquet
- CSV
- JSON

Typical flow:

```text
Raw Data
   ↓
Lakehouse
   ↓
PySpark / Spark
   ↓
Transformation
   ↓
Curated Data
```

### Warehouse

Focused on SQL-based analytical workloads.

Common technologies:

- SQL
- Tables
- Views
- Analytical queries
- BI tools

Typical flow:

```text
Structured Data
      ↓
   Warehouse
      ↓
     SQL
      ↓
Analytics / BI
```

### ⭐ Easy memory

```text
Lakehouse
→ Spark + Data Engineering

Warehouse
→ SQL + Analytics
```

---

## 8. Warehouse Architecture in Our Project

```text
Azure SQL Database
        ↓
     Mirroring
        ↓
Fabric Mirrored Database
        ↓
Transformation / ELT
        ↓
Fabric Warehouse
        ↓
Data Modeling
        ↓
Security + Governance
        ↓
Analytics / BI
```

### Important

```text
Mirroring
→ Replicates source data

Transformation / ELT
→ Prepares data

Warehouse
→ Provides analytical SQL layer

Data Modeling
→ Organizes analytical data
```

### ⭐ Easy memory

```text
Mirroring  = Replicate
Transform  = Prepare
Warehouse  = Analyze
Modeling   = Organize
```

---

## 9. Warehouse Tables

A table is a structured collection of data organized into rows and columns.

Example:

```text
Customers

CustomerID | CustomerName | Region
-----------------------------------
1          | Ravi         | South
2          | Anil         | North
3          | Priya        | West
```

- **Row** → one record
- **Column** → one attribute

```text
Table
→ Stores structured data

Row
→ One record

Column
→ One attribute
```

---

## 10. Views

A **View** is a saved SQL query that provides a logical way to access data from one or more database objects.

Example:

```sql
CREATE VIEW vw_CustomerSales AS
SELECT
    CustomerName,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerName;
```

Query it with:

```sql
SELECT *
FROM vw_CustomerSales;
```

### Why use views?

- Simplify complex queries
- Reuse SQL logic
- Provide business-friendly data access
- Present selected data to reporting users

```text
Table
→ Stores data

View
→ Presents data through a saved SQL query
```

---

## 11. Schemas

A **Schema** is a logical container used to organize database objects.

Example:

```text
Warehouse
│
├── staging
├── warehouse
└── reporting
```

### Why use schemas?

- Organize database objects
- Separate logical areas
- Improve maintainability
- Support security and permissions

```text
Schema
→ Organizes objects

Table
→ Stores data
```

---

## 12. Stored Procedures

A **Stored Procedure** is reusable SQL logic stored in the database and executed when required.

Possible uses:

- Data loading
- SQL transformations
- Reusable processing logic
- ELT workflows

```text
Stored Procedure
       ↓
Reusable SQL Logic
       ↓
Execute when required
```

### View vs Stored Procedure

```text
View
→ Mainly presents/reads data

Stored Procedure
→ Executes reusable SQL logic
```

> **Note:** Fabric Warehouse has its own supported T-SQL surface. Use stored procedures only when they provide useful functionality in the project.

---

## 13. Historical Data

A major purpose of a Data Warehouse is historical analysis.

```text
2024 → Sales
2025 → Sales
2026 → Sales
```

This allows analysis of:

- Trends
- Growth
- Performance
- Seasonality
- Year-over-year changes

Example:

```text
How did sales change between 2024 and 2026?
```

---

## 14. Analytical Workloads

Typical Data Warehouse workloads include:

```text
SELECT
JOIN
GROUP BY
SUM()
COUNT()
AVG()
MIN()
MAX()
```

Example:

```sql
SELECT
    Region,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY Region;
```

The goal is to answer business questions rather than process individual transactions.

---

## 15. Warehouse Is Not Just a Copy of the Source

A common misconception is:

```text
Source Database
       ↓
Exact Copy
       ↓
Warehouse
```

A more realistic flow is:

```text
Source
   ↓
Replication
   ↓
Transformation / ELT
   ↓
Analytical Structure
   ↓
Warehouse
   ↓
Analytics
```

> A Data Warehouse is not simply a copy of the operational database. It is an analytical layer designed for business analysis.

---

## 16. Core Characteristics

Remember:

- Analytical
- Historical
- Structured
- SQL-friendly
- Reporting-oriented
- BI-friendly
- Designed for analytical workloads
- Supports business analysis

---

# ⭐ Interview Questions

### Q1. What is a Data Warehouse?

A Data Warehouse is a centralized analytical data store designed for structured and historical business data used for reporting, analytics, and BI.

### Q2. Why do we need a Data Warehouse?

To support analytical workloads, historical analysis, reporting, and BI without relying on the operational database for heavy analytical workloads.

### Q3. OLTP vs OLAP?

OLTP systems are optimized for day-to-day transactions, while OLAP systems are optimized for analytical queries and business analysis.

### Q4. Why is historical data important?

It allows organizations to analyze trends, growth, performance, and changes over time.

### Q5. What is Microsoft Fabric Warehouse?

A SQL-based analytical data store designed for structured data and analytical workloads.

### Q6. Warehouse vs Lakehouse?

Warehouse focuses primarily on SQL-based structured analytics, while Lakehouse is strongly suited to data engineering and Spark-based workloads and supports files and tables.

### Q7. Is Mirroring the same as a Warehouse?

No.

```text
Mirroring
→ Replicates source data

Warehouse
→ Provides an analytical data layer
```

### Q8. Is a Data Warehouse simply a copy of the source database?

No. Data can be transformed, cleaned, integrated, and organized for analytical workloads before or within the Warehouse layer.

---

# 🧠 Final Revision

```text
Warehouse
→ Centralized analytical data store

OLTP
→ Run the business

OLAP
→ Analyze the business

Source Database
→ Transactional efficiency
→ Normalization / 3NF is common

Data Warehouse
→ Analytical efficiency
→ Star/Snowflake schemas are common

Fabric Warehouse
→ SQL + Structured Data + Analytics

Lakehouse
→ Spark + Data Engineering

Mirroring
→ Replicate source data

Transformation
→ Prepare data

Warehouse
→ Analytical SQL layer

Historical Data
→ Trends + Business Analysis

Table
→ Stores data

View
→ Presents data through saved SQL logic

Schema
→ Organizes database objects

Stored Procedure
→ Reusable SQL logic
```

---

# 🚫 Topics Reserved for 03 — Data Modeling

Do **not** mix these into the Warehouse module:

- Fact Tables
- Dimension Tables
- Star Schema
- Snowflake Schema
- Primary Keys / Foreign Keys in dimensional modeling
- Relationships
- Grain
- Measures
- SCD Type 1
- SCD Type 2
- Surrogate Keys
- Dimensional modeling techniques

These will be covered properly in:

```text
03_Data_Modeling
```

---

# ✅ Module Status

```text
02 — Data Warehouse Concepts

Core concepts → COMPLETE ✅

Next:
Build the Fabric Warehouse practically
```
