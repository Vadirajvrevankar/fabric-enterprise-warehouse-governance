# Object-Level Security (OLS)

## Overview

This project demonstrates Object-Level Security (OLS) using Azure Synapse Dedicated SQL Pool.

OLS controls which database objects a user or database role can access.

## What Was Implemented

- Created Sales and Payroll demo tables
- Created `OLSAnalyst` database role
- Granted `SELECT` permission on `OLSSalesDemo`
- Did not grant `SELECT` permission on `OLSPayrollDemo`
- Verified object-level permissions
- Tested object access
- Documented the environment limitation for restricted-user testing

## OLS Flow

    OLSAnalyst
         ↓
    Object Permissions
         ↓
    OLSSalesDemo    → SELECT GRANT ✅
    OLSPayrollDemo  → No SELECT GRANT ❌

## Demo Objects

### Sales Table

`warehouse.OLSSalesDemo`

    SaleID | CustomerName | Region | SalesAmount
    -------|--------------|--------|------------
    1001   | Rahul        | North  | 50000
    1002   | Priya        | South  | 60000
    1003   | Kiran        | West   | 70000

### Payroll Table

`warehouse.OLSPayrollDemo`

    EmployeeID | EmployeeName | Salary
    -----------|--------------|-------
    1          | Rahul        | 80000
    2          | Priya        | 70000
    3          | Kiran        | 75000

## Security Role

`OLSAnalyst`

The role has:

    OLSSalesDemo → SELECT / GRANT

The role does not have:

    OLSPayrollDemo → No SELECT GRANT

## Permission Verification

The final permission check confirmed that `OLSAnalyst` has `SELECT` permission on `OLSSalesDemo` and no explicit `SELECT` permission on `OLSPayrollDemo`.

## Testing Note

The current Synapse account may still be able to access `OLSPayrollDemo` because it can have additional permissions beyond the `OLSAnalyst` role.

Therefore, the object-level security configuration was verified through database permission metadata. A completely isolated restricted-user test was not performed in this environment.

## Project Structure

    08_OLS/
    ├── README.md
    ├── sql/
    │   └── 01_OLS_Demo_Data.sql
    └── screenshots/
        ├── 01_OLS_Demo_Data.png
        ├── 02_OLS_Role.png
        ├── 03_OLS_Object_Permissions.png
        ├── 04_OLS_Final_Permissions.png
        └── 05_OLS_Access_Test.png

## Key Learning

    OLS → Which OBJECTS can I access?
    RLS → Which ROWS can I access?
    CLS → Which COLUMNS can I access?
    Masking → How is the VALUE displayed?

> **OLS = Controls access to database objects.**

## Technologies

- SQL
- Azure Synapse Dedicated SQL Pool
- Object-Level Security
- Database Roles
- Object Permissions
- GRANT / DENY / REVOKE
- Git
- GitHub .....
