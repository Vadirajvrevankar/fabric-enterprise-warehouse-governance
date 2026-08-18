# Microsoft Fabric Mirroring — Azure SQL Database

## 📌 Project Overview

This project demonstrates **Microsoft Fabric Mirroring** using an **Azure SQL Database** as the source.

The project replicates an e-commerce source database into a **Fabric Mirrored Database** and verifies both initial replication and ongoing data changes.

---

## 🎯 Project Objective

The main objectives are:

- Configure Azure SQL Database as the source.
- Create sample e-commerce tables and data.
- Configure Microsoft Fabric Mirroring.
- Replicate source data into Fabric.
- Verify initial replication.
- Test `INSERT`, `UPDATE`, and `DELETE` change replication.
- Document the complete implementation.

---

## 🏗️ Architecture

```text
                 Azure SQL Database
                    ECommerceDB
                         │
                         │
                    Mirroring
                         │
                         ↓
              Microsoft Fabric
                         │
                         ↓
               ECommerceDB_Mirror
                         │
              ┌──────────┼──────────┐
              ↓          ↓          ↓
          Customers   Products    Orders
                         │
                         ↓
                 Analytics / ELT
```

---

## 🗄️ Source Database

**Platform:** Azure SQL Database

**Database:**

```text
ECommerceDB
```

### Source Tables

```text
Customers
Products
Orders
```

---

## 📊 Source Data Model

### Customers

| Column | Description |
|---|---|
| CustomerID | Unique customer identifier |
| CustomerName | Customer name |
| Region | Customer region |

### Products

| Column | Description |
|---|---|
| ProductID | Unique product identifier |
| ProductName | Product name |
| Category | Product category |
| Price | Product price |

### Orders

| Column | Description |
|---|---|
| OrderID | Unique order identifier |
| CustomerID | Customer reference |
| ProductID | Product reference |
| OrderDate | Order date |
| Quantity | Quantity ordered |
| Amount | Order amount |

---

## 🔄 Fabric Mirroring Configuration

**Fabric destination:**

```text
ECommerceDB_Mirror
```

The Azure SQL database was connected to Microsoft Fabric and configured for Mirroring.

The following source tables were configured for replication:

```text
Customers
Products
Orders
```

---

## 📥 Initial Replication

After Mirroring was started, the existing source data was replicated into Fabric.

Initial source data:

```text
Customers → 3 rows
Products  → 3 rows
Orders    → 3 rows
```

The Fabric Mirrored Database successfully received the replicated data.

---

# 🔄 Change Replication Testing

To verify that Mirroring handles ongoing source changes, three tests were performed.

## 1. INSERT Test

A new customer was inserted into the Azure SQL source:

```sql
INSERT INTO Customers (CustomerID, CustomerName, Region)
VALUES (4, 'Kiran', 'East');
```

### Result

```text
Azure SQL
    ↓
INSERT Customer 4
    ↓
Mirroring
    ↓
Fabric
    ↓
Customer 4 replicated successfully
```

**Status: ✅ Passed**

---

## 2. UPDATE Test

The newly inserted customer's region was updated:

```sql
UPDATE Customers
SET Region = 'Central'
WHERE CustomerID = 4;
```

### Result

The change was replicated from Azure SQL to Fabric.

```text
Before:
Kiran → East

After:
Kiran → Central
```

**Status: ✅ Passed**

---

## 3. DELETE Test

The temporary test customer was deleted from the source:

```sql
DELETE FROM Customers
WHERE CustomerID = 4;
```

### Result

The deletion was reflected in the Fabric mirrored data.

**Status: ✅ Passed**

---

# 🧪 Testing Summary

| Test | Source Change | Fabric Result | Status |
|---|---|---|---|
| Initial Load | Existing data | Data replicated | ✅ Passed |
| INSERT | Added Customer 4 | Customer replicated | ✅ Passed |
| UPDATE | East → Central | Update replicated | ✅ Passed |
| DELETE | Customer 4 deleted | Delete replicated | ✅ Passed |

---

# 📁 Project Structure

```text
01_Mirroring/
│
├── README.md
├── Mirroring_Notes.md
│
├── sql/
│   ├── 01_Create_Tables.sql
│   ├── 02_Insert_Sample_Data.sql
│   ├── 03_Insert_Test.sql
│   ├── 04_Update_Test.sql
│   ├── 05_Delete_Test.sql
│   └── 06_Verify_Source_Data.sql
│
└── screenshots/
    ├── 01_Azure_SQL_Database.png
    ├── 02_Source_Tables.png
    ├── 03_Fabric_Mirroring.png
    ├── 04_Initial_Replication.png
    ├── 05_Insert_Replication.png
    ├── 06_Update_Replication.png
    └── 07_Delete_Replication.png
```

> Screenshot filenames are examples. Add only the screenshots you actually captured.

---

# 🔐 Security

No credentials or secrets are stored in this repository.

Do **not** commit:

- SQL passwords
- Connection strings containing credentials
- API keys
- Access tokens
- Private IP information
- Other sensitive configuration

---

# 🧠 Key Learnings

Through this project, I learned:

- How Azure SQL Database can act as a source for Fabric Mirroring.
- How to configure a Fabric Mirrored Database.
- How initial replication works.
- How ongoing source changes are replicated.
- How `INSERT`, `UPDATE`, and `DELETE` changes can be verified.
- The difference between source data and mirrored data.
- The role of Mirroring in a Fabric data engineering architecture.

---

# ⭐ Final Result

```text
Azure SQL Database
        ↓
     Mirroring
        ↓
Fabric Mirrored Database
        ↓
Initial Replication       ✅
INSERT Replication        ✅
UPDATE Replication        ✅
DELETE Replication        ✅
```

## ✅ Project Status

**Fabric Mirroring Project — COMPLETED**
