# Access Control — Complete Notes

## 1. Definition

**Access Control** is the process of controlling who can access what data or database objects and what actions they are allowed to perform.

> **Access Control = Who can do what?**

---

## 2. Why Access Control Is Used

Access control is used to:

- Protect sensitive data
- Prevent unauthorized access
- Prevent accidental data modification
- Prevent unauthorized deletion
- Separate responsibilities between teams
- Follow the Principle of Least Privilege
- Support security and compliance requirements

---

## 3. Authentication vs Authorization

### Authentication

> **Who are you?**

Authentication verifies the identity of the user.

Example:

```text
Username + Password
        ↓
SQL Server verifies identity
```

### Authorization

> **What are you allowed to do?**

Authorization determines what an authenticated user can access or modify.

Example:

```text
Analyst
   ↓
SELECT Sales       → Allowed
DELETE Sales       → Not Allowed
```

### Remember

```text
Authentication → Who are you?
Authorization  → What can you do?
```

---

## 4. SQL Server Access Control Structure

```text
LOGIN
   ↓
USER
   ↓
ROLE
   ↓
PERMISSION
   ↓
DATABASE OBJECT
```

Example:

```text
SalesAnalyst
     ↓
Database User
     ↓
SalesReader Role
     ↓
SELECT
     ↓
FactSales
```

---

## 5. Login

A **Login** is a server-level identity used to connect to SQL Server.

Example:

```text
analyst_login
```

A Login exists at the SQL Server instance level and can be mapped to a database User.

```text
Login
  ↓
Database User
```

---

## 6. User

A **User** is an identity inside a particular database.

Example:

```text
SQL Server
    │
    └── SalesDB
          ├── analyst_user
          └── engineer_user
```

A Login can be associated with a database User.

---

## 7. Role

A **Role** is a group used to manage permissions.

Instead of giving permissions individually to many users:

```text
User 1 → SELECT
User 2 → SELECT
User 3 → SELECT
```

Create a role:

```text
SalesReader
```

Give the role the permission:

```text
SalesReader
     ↓
SELECT
```

Then add users to the role:

```text
SalesReader
     │
     ├── User 1
     ├── User 2
     └── User 3
```

Roles make security easier to manage.

---

## 8. Server Roles vs Database Roles

### Server Roles

Server roles control server-level capabilities.

Examples:

```text
sysadmin
securityadmin
serveradmin
```

### Database Roles

Database roles control permissions inside a database.

Examples:

```text
db_datareader
db_datawriter
db_owner
```

You can also create custom roles:

```text
SalesReader
SalesWriter
FinanceReader
```

Custom roles allow more precise access control.

---

## 9. Permissions

A **Permission** defines what a User or Role is allowed to do.

Common permissions:

| Permission | Meaning |
|---|---|
| SELECT | Read data |
| INSERT | Add data |
| UPDATE | Modify existing data |
| DELETE | Delete data |
| EXECUTE | Execute stored procedures/functions |
| ALTER | Change an object's definition |
| CONTROL | Broad control over a securable |

---

## 10. GRANT

`GRANT` gives permission.

Example:

```sql
GRANT SELECT ON warehouse.FactSales TO SalesReader;
```

Meaning:

> Members of `SalesReader` can read `FactSales`.

```text
SalesReader
     ↓
SELECT
     ↓
FactSales
```

---

## 11. DENY

`DENY` explicitly prevents a permission.

Example:

```sql
DENY DELETE ON warehouse.FactSales TO SalesReader;
```

Meaning:

> Members of `SalesReader` cannot delete rows from `FactSales`.

---

## 12. REVOKE

`REVOKE` removes an explicitly granted or denied permission.

Example:

```sql
REVOKE SELECT ON warehouse.FactSales FROM SalesReader;
```

Important:

```text
GRANT  → Give permission
DENY   → Explicitly block permission
REVOKE → Remove an explicit permission
```

`REVOKE` does not mean "grant access."

---

## 13. GRANT vs DENY vs REVOKE

```text
GRANT
  ↓
Give permission

DENY
  ↓
Explicitly block permission

REVOKE
  ↓
Remove the explicit permission
```

---

## 14. Principle of Least Privilege

The **Principle of Least Privilege** means:

> Give a user only the minimum permissions required to perform their job.

Bad:

```text
Analyst
→ SELECT
→ INSERT
→ UPDATE
→ DELETE
```

Better:

```text
Analyst
→ SELECT only
```

If an analyst only needs to read data, there is no reason to give them permission to modify or delete it.

---

## 15. Object-Level Access

Permissions can be applied to database objects such as:

- Database
- Schema
- Table
- View
- Stored Procedure
- Function

Example:

```text
SalesReader
     ↓
SELECT
     ↓
FactSales
```

A role may be allowed to access one object but not another.

---

## 16. Schema-Level Security

A schema groups database objects.

Example:

```text
warehouse
   ├── FactSales
   ├── DimCustomer
   └── DimProduct
```

Permissions can be granted at the schema level instead of individually granting them to every table.

This is useful when a database contains many related tables.

---

## 17. Column-Level Access

Access can also be restricted at the column level.

Example:

```text
Employee
--------------------------------
EmployeeID
Name
Department
Salary
```

An analyst may be allowed to access:

```text
EmployeeID
Name
Department
```

but not:

```text
Salary
```

This concept is covered in more detail under **Column-Level Security (CLS)**.

---

## 18. Row-Level Security

Access can also be restricted by rows.

Example:

```text
Sales
-----------------------
Employee | Region | Sales
A        | North  | 50000
B        | South  | 60000
C        | North  | 40000
```

A North manager may see:

```text
A | North | 50000
C | North | 40000
```

but not:

```text
B | South | 60000
```

This is **Row-Level Security (RLS)**.

---

## 19. Access Control vs RLS vs CLS vs OLS vs Data Masking

| Security Concept | Main Question |
|---|---|
| Access Control | Can this user access the object? |
| RLS | Which rows can this user see? |
| CLS | Which columns can this user access? |
| OLS | Which protected data/objects can this user access based on security classification? |
| Data Masking | How should sensitive values appear to the user? |

Easy way to remember:

```text
ACCESS CONTROL
      ↓
Can you access it?

RLS
      ↓
Which rows?

CLS
      ↓
Which columns?

OLS
      ↓
Which protected data/objects?

MASKING
      ↓
How much of the value should you see?
```

---

## 20. Fixed Roles vs Custom Roles

SQL Server provides built-in database roles such as:

```text
db_datareader
db_datawriter
db_owner
```

However, broad roles may provide more access than a user actually needs.

Custom roles can provide more controlled access:

```text
SalesReader
SalesAnalyst
SalesAdmin
```

---

## 21. Role-Based Access

Suppose:

```text
User = Ravi
```

and Ravi belongs to:

```text
SalesReader
```

If `SalesReader` has:

```text
SELECT on FactSales
```

then Ravi receives that permission through the role.

```text
Ravi
 ↓
SalesReader
 ↓
SELECT
 ↓
FactSales
```

This is easier to manage than assigning permissions individually to every user.

---

## 22. Direct Permission vs Role Permission

Permissions can be assigned directly:

```text
Ravi
 ↓
SELECT
 ↓
FactSales
```

Or through a role:

```text
Ravi
 ↓
SalesReader
 ↓
SELECT
 ↓
FactSales
```

For organizations with many users, role-based access is generally easier to maintain.

---

## 23. Security Hierarchy

A useful mental model is:

```text
SQL Server
    ↓
Database
    ↓
Schema
    ↓
Object
    ↓
Column
    ↓
Row
```

Different security mechanisms can operate at different levels.

---

## 24. Important SQL Server Notes

SQL Server has more advanced permission rules.

For example:

- Database owners have extensive control.
- `sysadmin` members effectively bypass normal database permission checks.
- Permissions can come through multiple roles.
- `DENY` generally takes precedence over `GRANT`, with important exceptions.
- Ownership and higher-level permissions can affect permission evaluation.

These advanced cases are not required for the first practical exercise.

---

## 25. Real-World Example

### Data Engineer

```text
Can:
SELECT
INSERT
UPDATE

Should not automatically:
DELETE production data
```

### Data Analyst

```text
Can:
SELECT

Cannot:
INSERT
UPDATE
DELETE
```

### Finance Manager

```text
Can:
SELECT financial data

Cannot:
Modify warehouse data
```

### Application User

```text
Can:
EXECUTE approved procedures

Cannot:
Directly modify tables
```

This separation reduces security risk.

---

## 26. Interview Questions

### What is Access Control?

> Access Control manages who can access database resources and what actions they can perform.

### Authentication vs Authorization?

> Authentication verifies who the user is; authorization determines what the user is allowed to do.

### What is a database role?

> A database role is a group of users to which permissions can be assigned collectively.

### GRANT vs DENY?

> GRANT allows a permission, while DENY explicitly prevents it.

### What does REVOKE do?

> REVOKE removes an explicitly granted or denied permission.

### Why use roles?

> Roles simplify permission management and support consistent and scalable security.

### What is Least Privilege?

> Give users only the minimum permissions necessary to perform their job.

### Access Control vs RLS?

> Access Control determines whether a user can access an object, while RLS determines which rows within the accessible data the user can see.

---

## 27. Key Points to Remember

```text
LOGIN  → Connect to SQL Server
USER   → Identity inside a database
ROLE   → Group of users
GRANT  → Give permission
DENY   → Block permission
REVOKE → Remove explicit permission
```

### Most Important Rule

> **Access Control = Who can do what?**

---

## 28. Practical Learning Flow

After completing the theory, the practical implementation will follow:

```text
Create Demo Objects
        ↓
Create Database Role
        ↓
Create/Test User
        ↓
GRANT Permissions
        ↓
Test Access
        ↓
DENY Permissions
        ↓
Test Again
        ↓
REVOKE Permissions
        ↓
Verify Results
        ↓
Screenshot
        ↓
SQL File + README
        ↓
Git Commit
```

## Final Summary

Access Control is the foundation of database security.

The core model is:

```text
LOGIN
  ↓
USER
  ↓
ROLE
  ↓
PERMISSION
  ↓
DATABASE OBJECT
```

The core commands are:

```text
GRANT  → Allow
DENY   → Block
REVOKE → Remove explicit permission
```

And the most important security principle is:

> **Give users only the permissions they need — no more, no less.**
