# Column-Level Security (CLS)

## Definition

Column-Level Security (CLS) controls which columns a user or database role can access in a table.

> **CLS = Controls access to specific columns.**

## Why CLS Is Used

CLS is used to:

- Protect sensitive columns
- Follow the principle of least privilege
- Prevent unnecessary access to confidential information
- Separate sensitive and non-sensitive data access
- Protect PII and financial information

## Simple Example

```text
EmployeeID | EmployeeName | Department | Salary
------------------------------------------------
1          | Rahul        | IT         | 80000
2          | Priya        | Finance    | 75000
```

An analyst may need:

```text
EmployeeID
EmployeeName
Department
```

but should not access:

```text
Salary
```

## Easy Definition

> **Column-Level Security restricts users or roles from accessing specific columns in a database table.**

## Access Control vs RLS vs CLS

```text
Access Control → Can I access the object?
RLS            → Which rows can I access?
CLS            → Which columns can I access?
```

## Example

```text
Employee
-----------------------------------------------
EmployeeID | Name | Department | Salary | SSN
```

A reporting analyst may need EmployeeID, Name, and Department, but not Salary or SSN.

CLS can restrict access to those sensitive columns.

## CLS and Roles

CLS commonly works together with database roles:

```text
AnalystRole
    ↓
Allowed Columns
    ↓
EmployeeID
EmployeeName
Department
```

A privileged role may have access to additional sensitive columns.

## Principle of Least Privilege

A user should receive only the permissions required for their job.

Example:

```text
Data Analyst
→ EmployeeID
→ EmployeeName
→ Department

HR Manager
→ EmployeeID
→ EmployeeName
→ Department
→ Salary
```

> **Don't give access to sensitive columns unless the job requires it.**

## Column-Level Permissions

SQL platforms can support permissions at column level. Conceptually:

```sql
GRANT SELECT
ON Employee(EmployeeName, Department)
TO AnalystRole;
```

The exact supported syntax and behavior depends on the Azure Synapse SQL environment, so practical implementation must use syntax supported by the target environment.

## CLS vs RLS

Suppose:

```text
EmployeeID | Region | Name | Salary
------------------------------------
1          | North  | Rahul | 80000
2          | South  | Priya | 75000
```

RLS could restrict a North user to Rahul's row.

CLS could restrict an analyst from accessing Salary.

They can also be combined:

```text
User
 ↓
RLS → Which rows?
 ↓
CLS → Which columns?
```

## CLS vs Dynamic Data Masking

CLS controls whether the user can access the column.

```text
Salary
 ↓
No permission
 ↓
Access denied
```

Dynamic Data Masking controls how an accessible value is displayed.

```text
Salary
 ↓
Masking
 ↓
*****
```

Remember:

```text
CLS
→ Can I access the column?

Masking
→ If I can access it, how is the value displayed?
```

## Real-World Example

A banking warehouse might contain:

```text
CustomerID | Name | City | AccountNumber | Balance
```

A reporting analyst may need CustomerID, Name, and City but not AccountNumber or Balance.

CLS can restrict those sensitive columns.

## Common Use Cases

### HR

- Salary
- BankAccount
- PersonalInformation

### Banking

- AccountNumber
- Balance
- CreditInformation

### Healthcare

- MedicalInformation
- Diagnosis
- InsuranceInformation

### E-commerce

- PaymentInformation
- CustomerPhone
- PersonalInformation

## CLS Architecture

```text
User
  ↓
Database Role
  ↓
Column Permissions
  ↓
Table
  ↓
Allowed Columns
```

## CLS Testing

A proper test should verify:

```text
Analyst
 ↓
SELECT EmployeeID, EmployeeName, Department
 ↓
Success
```

and:

```text
Analyst
 ↓
SELECT Salary
 ↓
Permission denied
```

The exact test depends on the identity and role setup available in the environment.

## Important SELECT * Consideration

If a role does not have permission on a sensitive column, a query such as:

```sql
SELECT *
FROM Employee;
```

may fail rather than simply returning only permitted columns, depending on the permission configuration.

Therefore, test explicitly:

```sql
SELECT EmployeeID, EmployeeName, Department
FROM Employee;
```

and:

```sql
SELECT Salary
FROM Employee;
```

## Benefits

- Protects sensitive columns
- Supports least privilege
- Reduces unnecessary data exposure
- Centralizes database security
- Supports compliance controls

## Limitations and Considerations

- Column permissions can become complex
- Sensitive columns should be identified through data classification
- BI/reporting tools must be tested
- Queries using multiple columns should be tested
- Permissions should follow least privilege
- Administrative identities may have broader access
- Exact implementation depends on the SQL platform

## CLS vs Dynamic Data Masking

| Feature | CLS | Dynamic Data Masking |
|---|---|---|
| Controls | Column access | Value display |
| Access | May be denied | User generally has column access |
| Sensitive value | Not accessible | May be partially hidden |
| Example | Salary access denied | Salary shown as masked |
| Main question | Can I access this column? | What value should I see? |

## CLS vs RLS vs Masking

```text
Access Control
      ↓
Can I access the object?

RLS
      ↓
Which rows can I access?

CLS
      ↓
Which columns can I access?

Dynamic Data Masking
      ↓
How is the value displayed?
```

## Data Engineer Perspective

A Data Engineer should understand:

- Why CLS is required
- How column permissions work
- How roles are used
- How to protect sensitive columns
- How CLS differs from RLS
- How CLS differs from Dynamic Data Masking
- How to test column permissions
- How to implement least privilege

## Interview Definition

> **Column-Level Security is a database security mechanism that restricts access to specific columns of a table based on a user's or role's permissions.**

## Interview Questions

### Q1. What is CLS?

CLS restricts access to specific columns in a table.

### Q2. Why is CLS used?

To prevent users from accessing sensitive columns that are not required for their job.

### Q3. Give a real-world example.

An analyst can access EmployeeID and Department but cannot access Salary.

### Q4. CLS vs RLS?

RLS controls rows, while CLS controls columns.

### Q5. CLS vs Dynamic Data Masking?

CLS controls access to a column, while Dynamic Data Masking controls how a column's value is displayed.

### Q6. What is least privilege?

Giving users only the permissions required to perform their job.

### Q7. Can CLS and RLS be used together?

Yes. RLS can restrict rows while CLS restricts columns.

## Key Points to Remember

```text
CLS
 ↓
Column-Level Security
 ↓
Controls access to columns
```

Remember:

```text
RLS → ROWS
CLS → COLUMNS
```

And:

```text
CLS
→ Column cannot be accessed

Masking
→ Column can be accessed but value can be hidden
```

> **CLS = Which columns can this user access?**

## Practical Learning Flow

```text
Understand CLS
      ↓
Create Demo Employee Table
      ↓
Insert Sample Data
      ↓
Create Database Role
      ↓
Grant Required Column Permissions
      ↓
Restrict Sensitive Column
      ↓
Verify Permissions
      ↓
Test Authorized Columns
      ↓
Test Restricted Column
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

Column-Level Security protects sensitive columns by controlling which users or roles can access them.

```text
Employee Table
---------------------------------
EmployeeID | Name | Dept | Salary
```

Example:

```text
EmployeeID → ✅
Name       → ✅
Dept       → ✅
Salary     → ❌
```

The key concepts are:

> **Access Control → Can I access the object?**

> **RLS → Which rows can I access?**

> **CLS → Which columns can I access?**

> **Dynamic Data Masking → How is the value displayed?**
