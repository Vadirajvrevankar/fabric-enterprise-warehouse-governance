# 03 — Data Modeling Notes

## Overview
Dimensional Data Modeling organizes warehouse data for analytical queries using Fact Tables and Dimension Tables.

## 1. Fact Table
**Definition:** A Fact Table stores measurable business events.

**Memory:** Fact = What happened?

Example:
- E-commerce → Sale
- Banking → Transaction
- Hospital → Patient visit

Example `FactSales`:
```text
SalesKey
OrderID
CustomerKey
ProductKey
DateKey
Quantity
SalesAmount
```

## 2. Dimension Table
**Definition:** A Dimension Table stores descriptive information that provides context for Facts.

**Memory:** Dimension = Who / What / When / Where?

Examples:
```text
DimCustomer → Who?
DimProduct  → What?
DimDate     → When?
DimLocation → Where?
```

## 3. Fact vs Dimension

| Fact | Dimension |
|---|---|
| Business events | Descriptive context |
| What happened? | Who/What/When/Where? |
| Measures | Attributes |
| Usually large | Usually smaller |

## 4. Grain
**Definition:** Grain defines exactly what one row in a Fact Table represents.

Examples:
```text
One row = One Order
One row = One Order Line
```

Always define:
> One row in this Fact Table represents ______.

## 5. Star Schema ⭐
A Star Schema has a central Fact Table directly connected to surrounding Dimensions.

```text
                 DimCustomer
                      |
DimProduct ------ FactSales ------ DimDate
                      |
                  DimRegion
```

Benefits: simple, fewer joins, BI-friendly, easy analytical queries.

## 6. Snowflake Schema ❄️
A Snowflake Schema further normalizes Dimensions into related tables.

```text
DimCustomer
    |
  DimCity
    |
 DimState
```

**Star:** simpler, fewer joins.  
**Snowflake:** more normalized, more joins.

For our project: **Star Schema**.

## 7. Measures
A Measure is a numeric business value that can be calculated/analyzed.

Examples:
```text
Quantity
SalesAmount
CostAmount
DiscountAmount
ProfitAmount
```

### Additive
Can be summed across all relevant dimensions.
- SalesAmount
- Quantity
- Cost

### Semi-additive
Can be summed across some dimensions, but not all.
- Account Balance
- Inventory Balance
- Stock Level

### Non-additive
Should not simply be summed.
- Percentages
- Ratios
- Profit Margin

**Numeric does not automatically mean Measure.** `CustomerID` is numeric but is an identifier.

## 8. Surrogate Keys 🔑
A Surrogate Key is a Warehouse-generated unique identifier for a Dimension record.

```text
CustomerKey | CustomerID
------------|-----------
1           | 101
2           | 102
```

`CustomerID` = Business/Source Key  
`CustomerKey` = Surrogate Key

Useful for historical tracking, SCD Type 2, multiple source systems, and stable warehouse identifiers.

## 9. Slowly Changing Dimensions (SCD)
SCD techniques define how Dimension changes are handled.

### SCD Type 1
Overwrite the old value.

```text
South → North
```

History is lost.

### SCD Type 2
Preserve history by creating a new Dimension version.

```text
CustomerKey | CustomerID | Region | StartDate  | EndDate    | IsCurrent
-----------------------------------------------------------------------
1           | 101        | South  | 2025-01-01 | 2026-05-10 | 0
2           | 101        | North  | 2026-05-11 | NULL       | 1
```

Type 1 = Update/overwrite.  
Type 2 = Keep old + insert new version.

## 10. Date Dimension 📅
A dedicated Dimension containing calendar/business-calendar attributes.

Typical columns:
```text
DateKey
FullDate
Day
DayName
WeekNumber
Month
MonthName
Quarter
Year
FiscalMonth
FiscalQuarter
FiscalYear
IsWeekend
IsHoliday
```

Allows consistent analysis by day, week, month, quarter, year, and fiscal periods.

## 11. Fact & Dimension Relationships
Typical relationship:

```text
Dimension 1 ---- ∞ Fact
```

Example:
```text
DimCustomer 1 ---- ∞ FactSales
DimProduct  1 ---- ∞ FactSales
DimDate     1 ---- ∞ FactSales
```

Dimension primary key is referenced by the Fact as a foreign key.

## 12. Degenerate Dimension
A business identifier stored directly in the Fact without a separate Dimension.

Examples:
```text
OrderID
InvoiceNumber
TransactionNumber
```

Example:
```text
FactSales
├── OrderID        ← Degenerate Dimension
├── CustomerKey
├── ProductKey
├── DateKey
├── Quantity
└── SalesAmount
```

## 13. Role-Playing Dimension
One Dimension used multiple times for different business roles.

Example:
```text
FactSales
├── OrderDateKey
├── ShipDateKey
└── DeliveryDateKey
```

All three can reference the same `DimDate`.

```text
                 DimDate
                /   |              Order   Ship  Delivery
             \      |      /
                 FactSales
```

## 14. Types of Fact Tables

### Transaction Fact
One row = one business event.
Example: Sales.

### Periodic Snapshot
One row = an entity's state at a regular interval.
Example: Daily inventory.

### Accumulating Snapshot
One row = a process/lifecycle, updated through milestones.
Example:
```text
Placed → Paid → Packed → Shipped → Delivered
```

## 15. Conformed Dimensions
A Dimension shared consistently by multiple Fact Tables/business processes.

```text
              DimDate
             /   |               ↓    ↓    ↓
      FactSales FactReturns FactInventory
```

Provides consistent definitions and cross-process analysis.

## 16. Junk Dimension
Combines multiple small, unrelated, low-cardinality attributes into one Dimension.

Example:
```text
DimOrderFlags
JunkKey
IsGift
IsOnline
IsPriority
PaymentType
```

Useful instead of creating many tiny Dimensions.

## 17. Final Dimensional Model

Conceptually our e-commerce model is:

```text
                    DimCustomer
                         |
                         |
DimProduct -------- FactSales -------- DimDate
                         |
                         |
                     DimRegion
```

### FactSales
```text
SalesKey
OrderID
CustomerKey
ProductKey
DateKey
Quantity
SalesAmount
```

### DimCustomer
```text
CustomerKey
CustomerID
CustomerName
Region
```

### DimProduct
```text
ProductKey
ProductID
ProductName
Category
```

### DimDate
```text
DateKey
FullDate
Day
Month
MonthName
Quarter
Year
```

# 🧠 Quick Revision

```text
FACT
→ Business event

DIMENSION
→ Description/context

GRAIN
→ What does ONE row mean?

MEASURE
→ Business number

STAR
→ Fact + directly connected Dimensions

SNOWFLAKE
→ Normalized Dimensions

SURROGATE KEY
→ Warehouse-generated Dimension key

SCD TYPE 1
→ Overwrite

SCD TYPE 2
→ Preserve history

DATE DIMENSION
→ Calendar/business calendar

RELATIONSHIP
→ Dimension 1 : Many Fact

DEGENERATE DIMENSION
→ Identifier kept in Fact

ROLE-PLAYING DIMENSION
→ Same Dimension used in multiple roles

TRANSACTION FACT
→ Individual event

PERIODIC SNAPSHOT
→ State at regular intervals

ACCUMULATING SNAPSHOT
→ Process lifecycle

CONFORMED DIMENSION
→ Shared Dimension across Facts

JUNK DIMENSION
→ Small miscellaneous attributes grouped together
```

# Interview Quick Answers

**Fact Table:** Stores measurable business events.

**Dimension Table:** Stores descriptive attributes used to analyze Facts.

**Grain:** Defines the level of detail represented by one Fact row.

**Star Schema:** Central Fact directly connected to Dimensions.

**Snowflake Schema:** Dimensions are further normalized.

**Measure:** Numeric business metric used for analysis.

**Surrogate Key:** Warehouse-generated unique Dimension identifier.

**SCD Type 1:** Overwrites the old Dimension value.

**SCD Type 2:** Preserves historical Dimension versions.

**Conformed Dimension:** Shared Dimension used consistently across multiple Facts.

**Degenerate Dimension:** Business identifier kept directly in a Fact without a separate Dimension.

**Role-Playing Dimension:** One Dimension referenced multiple times for different business roles.

# Next: Practical Modeling

Theory is now complete.

```text
Source Warehouse Tables
        ↓
Define Fact Grain
        ↓
Design Dimensions
        ↓
Design Fact
        ↓
Choose Surrogate Keys
        ↓
Create Star Schema
        ↓
Load Data
        ↓
Implement SCD Type 2
        ↓
Validate
```

**Important:** Do not create tables blindly. First define the grain of `FactSales` and design the model.
