# Fabric Mirroring — Study Notes

## 1. Definition

Fabric Mirroring replicates data from a supported source database into Microsoft Fabric for analytics.

## 2. Why Do We Use Mirroring?

- Bring operational data into Fabric.
- Make fresh/near-real-time data available for analytics.
- Reduce the need for custom batch-copy processes for supported sources.
- Separate operational workloads from analytical workloads.

## 3. When Do We Use Mirroring?

Use Mirroring when:

- We already have a supported operational database.
- We need fresh data in Fabric.
- We want to analyze operational data in Fabric.
- A scheduled batch process is not suitable for the required freshness.

## 4. Basic Architecture

```text
Operational Database
        ↓
     Mirroring
        ↓
Fabric Mirrored Database
        ↓
Warehouse / Analytics
```

## 5. Source Database

The source database is the original operational database.

- Applications create, update, and delete data here.
- It is the source of the replicated data.

Example:

```text
Customers
Orders
Products
Payments
```

## 6. Mirrored Database

The mirrored database is the replicated representation of source data available in Fabric.

It can be used by downstream Fabric workloads for analytics and further processing.

## 7. Initial Load

When Mirroring is first configured, existing source data is initially replicated.

```text
Existing Source Data
        ↓
   Initial Load
        ↓
Fabric Mirrored Database
```

## 8. Change Replication

After the initial load, changes made in the source are replicated.

```text
INSERT  → New data
UPDATE  → Changed data
DELETE  → Deleted data
```

Example:

```text
Source:
Order 101 → ₹500

UPDATE

Order 101 → ₹700

        ↓

Fabric reflects the change
```

## 9. CDC — Change Data Capture

CDC is the concept/mechanism of identifying data changes such as:

- INSERT
- UPDATE
- DELETE

### Easy memory

> CDC = "What changed?"

For Fabric Mirroring, you do not normally build a separate manual CDC pipeline just to perform the mirroring. The mirroring capability handles the supported replication process.

## 10. Mirroring vs CDC vs ETL

| Concept | Main Purpose |
|---|---|
| **Mirroring** | Replicate source data into Fabric |
| **CDC** | Identify data changes |
| **ETL** | Extract + Transform + Load |

### Easy memory

```text
CDC       → What changed?
Mirroring → Keep source data replicated in Fabric
ETL       → Move + Transform + Load
```

## 11. Mirroring vs Backup

```text
Backup
→ Mainly for recovery

Mirroring
→ Mainly for making replicated data available
  for Fabric analytics
```

Mirroring should not be treated as a replacement for a backup/recovery strategy.

## 12. Mirroring vs Data Modeling

Mirroring:

```text
Source
  ↓
Fabric
```

Data Modeling:

```text
Replicated/processed data
  ↓
Fact + Dimensions
  ↓
Star Schema
```

Mirroring does not automatically create an analytical data model.

## 13. Mirroring vs Traditional ETL

Traditional ETL:

```text
Source
  ↓
Extract
  ↓
Transform
  ↓
Load
  ↓
Fabric
```

Mirroring:

```text
Source
  ↓
Mirroring
  ↓
Fabric
```

You may still perform transformations or ELT after the data reaches Fabric.

## 14. Important Considerations

- Mirroring works with supported source systems.
- It is primarily a replication capability.
- It does not automatically create a warehouse model.
- It does not replace every ETL/ELT requirement.
- Transformations may still be required after replication.
- Source schema changes need to be considered.
- Always check current Microsoft Fabric documentation for source-specific behavior and limitations.

## 15. How Mirroring Fits Our Project

```text
Operational Database
        ↓
     Mirroring
        ↓
Fabric Mirrored Data
        ↓
     Warehouse
        ↓
 Data Modeling
        ↓
Access Control / RLS / CLS / OLS
        ↓
Dynamic Data Masking
        ↓
     Governance
```

## 16. Interview Definition

> Fabric Mirroring is a capability that replicates data from supported operational sources into Microsoft Fabric, making fresh data available for analytics while reducing the need for traditional data-movement processes for the replicated data.

## ⭐ Key Points to Remember

1. Mirroring = Replication
2. Source = Original operational database
3. Mirrored Database = Replicated data in Fabric
4. Initial Load = Existing source data
5. Change Replication = Ongoing source changes
6. CDC = Identifies data changes
7. Mirroring ≠ Backup
8. Mirroring ≠ Data Modeling
9. Mirroring ≠ Complete ETL pipeline
10. Mirroring → Warehouse → Analytics

## Super-Short Revision

```text
SOURCE
   ↓
MIRRORING
   ↓
FABRIC
   ↓
WAREHOUSE
   ↓
ANALYTICS
```

**Mirroring = Keep source data replicated in Fabric.**

**CDC = What changed?**

**ETL = Move + Transform + Load.**
