# Object-Level Security (OLS)

## Definition

**Object-Level Security (OLS)** controls whether a user or database role can access a database object.

> **OLS = Controls access to database objects.**

## Why OLS Is Used

- Protect sensitive tables and views
- Prevent unauthorized object access
- Follow least privilege
- Separate access between teams
- Protect confidential business datasets

## Simple Example

```text
Database
├── SalesData     → Sales Analyst ✅
├── CustomerData  → Sales Analyst ✅
└── PayrollData   → Sales Analyst ❌
```

## Easy Definition

> **Object-Level Security restricts users or roles from accessing specific database objects based on their permissions.**

## Access Control vs RLS vs CLS vs OLS

```text
Access Control → Can I access the object?
RLS            → Which ROWS can I access?
CLS            → Which COLUMNS can I access?
OLS            → Which OBJECTS can I access?
```

## OLS and Database Roles

OLS is commonly implemented using database roles and permissions:

```text
User
 ↓
Database Role
 ↓
Object Permissions
 ↓
Table / View / Other Object
```

Example:

```text
SalesAnalyst
     ↓
SalesData → SELECT
```

## GRANT, DENY and REVOKE

### GRANT

Provides a permission.

```text
GRANT
  ↓
Permission is given
```

### DENY

Explicitly blocks a permission where supported.

```text
DENY
  ↓
Permission explicitly blocked
```

### REVOKE

Removes an explicit permission.

```text
REVOKE
  ↓
Remove explicit permission
```

> **REVOKE does not mean DENY.** REVOKE removes an explicit permission; another role may still provide access.

## Principle of Least Privilege

> Give a user only the access required to perform their job.

Example:

```text
Sales Analyst
    ↓
SalesData → SELECT
```

There is no reason to give access to PayrollData unless required.

## Real-World Example

An organization may have:

```text
SalesData
CustomerData
FinanceData
HRData
```

Different teams need different objects.

### Sales Team

```text
SalesData      → ✅
CustomerData   → ✅
FinanceData    → ❌
HRData         → ❌
```

### Finance Team

```text
SalesData      → maybe ✅
CustomerData   → maybe ✅
FinanceData    → ✅
HRData         → ❌
```

### HR Team

```text
SalesData      → ❌
CustomerData   → ❌
FinanceData    → ❌
HRData         → ✅
```

## OLS and Views

Views can be useful in security design:

```text
Sensitive Table
      ↓
Security View
      ↓
Analyst
```

The analyst can be given access to an approved view instead of the underlying sensitive table.

## OLS vs CLS

**OLS** controls access to the object:

```text
PayrollTable
     ↓
Access denied
```

**CLS** controls access to columns inside an accessible table:

```text
PayrollTable
     ↓
EmployeeName → ✅
Salary       → ❌
```

Remember:

```text
OLS → OBJECT
CLS → COLUMN
```

## OLS vs RLS

**OLS:**

```text
SalesTable
    ↓
Access / No Access
```

**RLS:**

```text
SalesTable
    ↓
North rows → visible
South rows → hidden
```

Remember:

```text
OLS → OBJECT
RLS → ROW
```

## OLS vs Dynamic Data Masking

**OLS:**

```text
PayrollTable
     ↓
Access denied
```

**Dynamic Data Masking:**

```text
Salary
 ↓
*****
```

Therefore:

```text
OLS     → Object access
CLS     → Column access
Masking → Value presentation
```

## Security Layers

```text
Object Access
      ↓
     OLS
      ↓
     Rows
      ↓
     RLS
      ↓
   Columns
      ↓
     CLS
      ↓
 Value Display
      ↓
   Masking
```

These controls can be combined depending on the security requirement.

## Example Combining Security Controls

```text
User
 ↓
OLS
 ↓
Can the user access PayrollData?
 ↓
RLS
 ↓
Which employee rows can they see?
 ↓
CLS
 ↓
Can they see Salary?
 ↓
Masking
 ↓
How should Salary be displayed?
```

## OLS Testing

A proper test should verify:

### Authorized Object

```text
SalesAnalyst
     ↓
SELECT from SalesData
     ↓
Success
```

### Unauthorized Object

```text
SalesAnalyst
     ↓
SELECT from PayrollData
     ↓
Permission denied
```

The exact result depends on the user's effective permissions and the SQL platform.

## Effective Permissions

A user can receive access through multiple paths.

```text
User
 │
 ├── SalesAnalyst role
 │       ↓
 │     SalesData → SELECT
 │
 └── Another role
         ↓
       PayrollData → SELECT
```

Therefore, security testing should consider **effective permissions**, not just one role.

## OLS in Azure Synapse

For Azure Synapse Dedicated SQL Pool, object access is primarily managed through SQL permissions and database roles.

Important concepts include:

- Database roles
- `GRANT`
- `DENY`
- `REVOKE`
- Object permissions
- Schemas
- Tables
- Views
- Stored procedures

> Always verify exact syntax against the Synapse Dedicated SQL Pool environment being used.

## Data Engineer Perspective

A Data Engineer should understand:

- What OLS means
- How database roles are used
- How object permissions work
- `GRANT`, `DENY`, and `REVOKE`
- Least privilege
- Effective permissions
- Difference between OLS, RLS, and CLS
- How to test object access

## Interview Definition

> **Object-Level Security is a database security mechanism that controls whether users or roles can access specific database objects such as tables, views, schemas, or stored procedures.**

## Interview Questions

### Q1. What is OLS?

OLS controls access to database objects.

### Q2. Why is OLS used?

To prevent unauthorized users from accessing sensitive database objects.

### Q3. Give a real-world example.

A Sales Analyst can access SalesData but cannot access PayrollData.

### Q4. OLS vs RLS?

OLS controls access to the object itself, while RLS filters rows within an accessible object.

### Q5. OLS vs CLS?

OLS controls object access, while CLS controls access to specific columns.

### Q6. What is least privilege?

Giving users only the permissions required for their job.

### Q7. What is GRANT?

GRANT gives a permission to a user or role.

### Q8. What is DENY?

DENY explicitly blocks a permission where supported.

### Q9. What is REVOKE?

REVOKE removes an explicit GRANT or DENY permission.

### Q10. Can OLS and RLS be used together?

Yes. Object access can be controlled first, while RLS can restrict which rows are visible inside an accessible object.

## Key Points to Remember

```text
OLS
 ↓
Object-Level Security
 ↓
Controls access to database objects
```

Remember:

```text
OLS → OBJECT
RLS → ROW
CLS → COLUMN
Masking → VALUE DISPLAY
```

> **OLS = Can this user access this database object?**

## Practical Learning Flow

```text
Understand OLS
      ↓
Create Demo Tables
      ↓
Create Database Role
      ↓
Grant Access to Required Object
      ↓
Do Not Grant Access to Sensitive Object
      ↓
Verify Object Permissions
      ↓
Test Authorized Object
      ↓
Test Unauthorized Object
      ↓
Take Screenshots
      ↓
Create SQL File
      ↓
Create README
      ↓
Git Commit
```

## Final Summary

Object-Level Security controls access to database objects.

```text
Database
│
├── SalesData
│      ↓
│    Analyst → ✅
│
├── CustomerData
│      ↓
│    Analyst → ✅
│
└── PayrollData
       ↓
     Analyst → ❌
```

The key concepts are:

> **OLS → Which objects can I access?**

> **RLS → Which rows can I access?**

> **CLS → Which columns can I access?**

> **Masking → How is the value displayed?**

## Technologies

- SQL
- Azure Synapse Dedicated SQL Pool
- Object-Level Security
- Database Roles
- GRANT / DENY / REVOKE
- Object Permissions
- Git
- GitHub
