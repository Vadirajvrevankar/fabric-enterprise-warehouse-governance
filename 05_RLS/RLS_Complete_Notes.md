# Row-Level Security (RLS)

## 1. Definition

**Row-Level Security (RLS)** is a database security feature that controls which rows a user can access in a table.

> **RLS = Controls which rows a user can see or modify.**

Different users can query the same table but receive different rows based on their identity, role, region, department, tenant, or other security rules.

---

## 2. Why RLS Is Used

RLS is used to:

- Restrict users to only the data they are authorized to see
- Protect sensitive business data
- Separate data by region, department, branch, or business unit
- Prevent users from accessing another team's data
- Support multi-tenant applications
- Keep data centralized instead of creating separate tables for each user/group

---

## 3. Simple Example

Suppose we have:

```text
Sales
--------------------------------
Employee | Region | SalesAmount
Rahul    | North  | 50000
Priya    | South  | 60000
Kiran    | North  | 40000
Anita    | South  | 55000
```

Without RLS:

```text
User
 ↓
SELECT *
 ↓
All 4 rows
```

With RLS:

```text
North User
     ↓
RLS Rule
     ↓
Rahul  | North | 50000
Kiran  | North | 40000
```

The South rows are hidden from the North user.

---

## 4. Easy Definition

> **RLS allows different users to see different rows from the same table based on security rules.**

---

## 5. Access Control vs RLS

### Access Control

Answers:

> **Can the user access the table?**

Example:

```text
SalesAnalyst
     ↓
SELECT on Sales
     ↓
Allowed
```

### RLS

Answers:

> **Which rows can the user access?**

Example:

```text
SalesAnalyst
     ↓
Sales Table
     ↓
Only North Region rows
```

Remember:

```text
Access Control
→ Can I access the object?

RLS
→ Which rows can I access?
```

---

## 6. RLS Architecture

A simple RLS design looks like:

```text
User
  ↓
User Identity / Role
  ↓
Security Rule
  ↓
Security Predicate
  ↓
Table
  ↓
Allowed Rows
```

Example:

```text
NorthUser
    ↓
Region = 'North'
    ↓
Sales Table
    ↓
Only North rows
```

---

## 7. Security Predicate

A **security predicate** is a rule that determines whether a row should be accessible or whether an operation should be allowed.

Conceptually:

```text
User Region = Row Region
```

If the condition is true:

```text
Row → Accessible
```

If the condition is false:

```text
Row → Restricted
```

Example:

```text
Current User Region = North
Row Region = North
        ↓
      TRUE
        ↓
      Allow
```

---

## 8. Filter Predicate

A **filter predicate** controls which rows are returned when a user reads data.

Example:

```text
User = NorthUser

SELECT *
FROM Sales;
```

The user receives:

```text
North rows only
```

South rows are filtered from the result.

Conceptually:

```text
Table
 ↓
RLS Filter
 ↓
Allowed Rows
 ↓
User
```

---

## 9. Block Predicate

A **block predicate** controls operations such as:

- INSERT
- UPDATE
- DELETE

It can prevent users from inserting or modifying rows that they are not authorized to manage.

Example:

```text
North User
    ↓
Attempts to UPDATE South row
    ↓
RLS Block Rule
    ↓
Operation rejected
```

---

## 10. Filter vs Block Predicate

| Predicate | Purpose |
|---|---|
| Filter Predicate | Controls which rows can be viewed |
| Block Predicate | Controls which rows can be inserted/updated/deleted |

Easy way to remember:

```text
FILTER
→ Controls what you can SEE

BLOCK
→ Controls what you can CHANGE
```

---

## 11. Common RLS Use Cases

### Regional Security

```text
North Manager → North data
South Manager → South data
West Manager  → West data
```

### Department Security

```text
HR User        → HR data
Finance User   → Finance data
Engineering    → Engineering data
```

### Branch Security

```text
Bangalore Branch → Bangalore data
Mysore Branch    → Mysore data
Hubli Branch     → Hubli data
```

### Multi-Tenant Applications

```text
Tenant A → Tenant A data
Tenant B → Tenant B data
Tenant C → Tenant C data
```

This prevents one customer or tenant from seeing another customer's data.

---

## 12. Real Company Example

Imagine an organization with sales teams across India:

```text
Sales Table
--------------------------------
OrderID | Region | Amount
1001    | North  | 50000
1002    | South  | 70000
1003    | North  | 45000
1004    | West   | 60000
```

A North Regional Manager should see:

```text
1001 | North | 50000
1003 | North | 45000
```

They should not see:

```text
1002 | South | 70000
1004 | West  | 60000
```

RLS can enforce this automatically.

---

## 13. RLS and Roles

RLS can work together with database roles.

Example:

```text
NorthSalesRole
      ↓
RLS Rule
      ↓
Region = North
      ↓
Sales Table
```

Another role:

```text
SouthSalesRole
      ↓
RLS Rule
      ↓
Region = South
      ↓
Sales Table
```

This allows different groups of users to access different rows.

---

## 14. RLS Does Not Create Separate Tables

Without RLS, someone might create:

```text
NorthSales
SouthSales
WestSales
```

With RLS, we can keep one table:

```text
Sales
```

and control access dynamically.

```text
Sales
 ├── North
 ├── South
 └── West
```

The security rule determines which rows each user can see.

---

## 15. RLS vs Separate Tables

### Without RLS

```text
NorthSales
SouthSales
WestSales
```

More tables can mean more maintenance.

### With RLS

```text
Sales
```

One centralized table can serve multiple users while security rules restrict their rows.

---

## 16. RLS and Data Warehousing

RLS is useful in a Data Warehouse when different business users need access to different parts of the same data.

Example:

```text
FactSales
    ↓
Region / Department / Tenant
    ↓
RLS
    ↓
Regional Users
```

It can protect warehouse data while allowing analysts to query centralized tables.

---

## 17. Important RLS Principle

RLS should be enforced at the **data/database security layer**, rather than relying only on an application to hide rows.

Why?

Users may access data through:

- SQL tools
- BI tools
- Applications
- Reports
- APIs

Database-level security provides a consistent security boundary.

---

## 18. RLS Benefits

### Security

Users only see authorized rows.

### Centralized Control

Security is enforced at the database layer.

### Reduced Data Leakage

Unauthorized rows can be filtered.

### Reusability

The same table can be used by multiple users.

### Scalability

Security rules can be applied across large datasets.

---

## 19. RLS Limitations and Considerations

RLS must be designed carefully.

Important considerations include:

- Security rules can add complexity
- Incorrect predicates can expose or hide incorrect data
- Performance should be considered
- Security rules must be tested thoroughly
- BI tools and reporting systems should be tested with the security model
- Administrative users may have elevated access

---

## 20. RLS Testing

A proper RLS test should verify different identities or roles.

Example:

```text
North User
    ↓
SELECT
    ↓
Only North rows
```

```text
South User
    ↓
SELECT
    ↓
Only South rows
```

Ideally:

```text
Admin
    ↓
SELECT
    ↓
All rows
```

---

## 21. RLS Testing Strategy

Test at least:

```text
Test 1
North User → North rows only

Test 2
South User → South rows only

Test 3
Admin → All rows

Test 4
North User → Attempt to access South data

Test 5
Unauthorized modification → Should be blocked where applicable
```

---

## 22. RLS vs CLS vs OLS vs Dynamic Data Masking

| Security Concept | Controls |
|---|---|
| Access Control | Access to database objects |
| RLS | Rows |
| CLS | Columns |
| OLS | Access to protected objects/data based on security rules |
| Dynamic Data Masking | How sensitive values are displayed |

Easy memory:

```text
Access Control → OBJECT ACCESS
RLS            → ROWS
CLS            → COLUMNS
OLS            → PROTECTED OBJECT/DATA ACCESS
Masking        → VALUE DISPLAY
```

---

## 23. Interview Definition

> **Row-Level Security is a database security mechanism that restricts access to individual rows based on the user's identity, role, or other security attributes.**

---

## 24. Interview Questions

### Q1. What is RLS?

> RLS restricts which rows a user can access in a table.

### Q2. Why is RLS used?

> To ensure users can only access the rows they are authorized to see or modify.

### Q3. Give a real-world example.

> A regional manager can see only the sales records belonging to their region.

### Q4. What is a security predicate?

> A security predicate is a security rule that determines whether a row should be accessible or whether an operation should be allowed.

### Q5. What is a filter predicate?

> A filter predicate controls which rows are returned when data is queried.

### Q6. What is a block predicate?

> A block predicate controls whether operations such as INSERT, UPDATE, or DELETE are allowed on particular rows.

### Q7. RLS vs Access Control?

> Access Control determines whether a user can access an object, while RLS determines which rows within that object the user can access.

### Q8. Why use RLS instead of separate tables?

> RLS allows multiple users to use the same centralized table while automatically restricting each user to authorized rows.

---

## 25. Key Points to Remember

```text
RLS
 ↓
Row-Level Security
 ↓
Controls individual rows
```

```text
Filter Predicate
→ Controls rows returned

Block Predicate
→ Controls INSERT / UPDATE / DELETE
```

Most important sentence:

> **RLS = Which rows can this user access?**

---

## 26. Practical Learning Flow

```text
Understand RLS
      ↓
Create Demo Sales Table
      ↓
Insert Multiple Regions
      ↓
Create Security Mapping
      ↓
Create RLS Rule
      ↓
Apply Security Predicate
      ↓
Test North User
      ↓
Test South User
      ↓
Verify Results
      ↓
Take Screenshots
      ↓
Create SQL File
      ↓
Create README
      ↓
Git Commit
```

---

## Final Summary

RLS provides row-level data security.

Instead of giving every user access to every row:

```text
User
  ↓
RLS Rule
  ↓
Authorized Rows
```

Example:

```text
North User
    ↓
RLS
    ↓
North rows only
```

The most important concepts to remember are:

> **Access Control asks: "Can I access this object?"**

> **RLS asks: "Which rows can I access?"**
