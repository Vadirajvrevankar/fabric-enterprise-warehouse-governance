# Data Modeling & Star Schema

## Overview

This project demonstrates the design and implementation of a Star Schema for sales analytics using SQL Server.

The project covers dimensional modeling, fact and dimension tables, data validation, data quality checks, analytical queries, and SCD Type 2.

## Business Problem

The business wants to analyze sales based on:

- Customers
- Products
- Regions
- Months

The goal is to build a reliable data warehouse model that supports analytical reporting.

## Data Flow

```text
Staging
   ↓
Dimension Tables
   ↓
FactSales
   ↓
Validation
   ↓
Data Quality
   ↓
Analytics



### Box 4 — Star Schema

```markdown
## Star Schema

```text
             DimCustomer
                  │
                  │
DimProduct ─── FactSales ─── DimDate



### Box 5 — Validation Results

```markdown
## Validation Results

| Check | Result |
|---|---|
| Fact Rows | 100 |
| Invalid Customer Keys | 0 |
| Invalid Product Keys | 0 |
| Invalid Date Keys | 0 |
| Total Sales | ₹4,116,800 |
| Total Quantity | 245 |
| Data Quality Checks | PASS |


## Analytical Queries

The Star Schema supports:

- Sales by Customer
- Sales by Product
- Sales by Region
- Sales by Month

Top Customer: Kavya — ₹578,000

Top Product: Laptop — ₹1,080,000


## SCD Type 2

SCD Type 2 was implemented on DimCustomer to preserve historical changes.

Example:

Customer 5
West → South

Old Version → IsCurrent = 0
New Version → IsCurrent = 1

This preserves historical customer information instead of overwriting the previous value.


## Project Structure

```text
03_Data_Modeling/
├── README.md
├── sql/
│   ├── 01_DimCustomer.sql
│   ├── 02_DimProduct.sql
│   ├── 03_DimDate.sql
│   ├── 04_FactSales.sql
│   ├── 05_Fact_Validation.sql
│   ├── 06_Business_Validation.sql
│   ├── 07_Analytical_Queries.sql
│   ├── 08_Data_Quality_Checks.sql
│   └── 09_SCD_Type_2_Customer.sql
└── screenshots/



### 📦 Box 9 — Technologies

```markdown
## Technologies

- SQL Server
- SQL
- Data Warehousing
- Dimensional Data Modeling
- Star Schema
- Data Quality
- SCD Type 2
- Git
- GitHub


## Project Outcome

Built and validated a complete Star Schema for sales analytics, including:

- Fact and Dimension modeling
- Surrogate key implementation
- Fact loading
- Data validation
- Data quality checks
- Analytical reporting
- SCD Type 2 historical tracking