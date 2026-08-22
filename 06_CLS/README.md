# Column-Level Security (CLS)

## Overview

This project demonstrates Column-Level Security (CLS) using Azure Synapse Dedicated SQL Pool.

CLS controls which columns a user or database role can access.

## What Was Implemented

- Created a demo employee table
- Created `CLSAnalyst` database role
- Granted `SELECT` permission on non-sensitive columns
- Restricted access to the sensitive `Salary` column
- Verified column-level permissions
- Tested column access
- Documented the environment limitation for restricted-user testing

## CLS Flow

    CLSAnalyst
         ↓
    Column Permissions
         ↓
    EmployeeID      → GRANT ✅
    EmployeeName    → GRANT ✅
    Department      → GRANT ✅
    Salary          → NO GRANT ❌

## Demo Table

`warehouse.CLSEmployeeDemo`

    EmployeeID | EmployeeName | Department        | Salary
    -----------|--------------|-------------------|-------
    1          | Rahul        | Data Engineering  | 80000
    2          | Priya        | Data Analytics    | 70000
    3          | Kiran        | Finance           | 75000
    4          | Anita        | HR                | 65000

## Security Role

`CLSAnalyst`

The role has `SELECT` permission on:

- `EmployeeID`
- `EmployeeName`
- `Department`

The role does **not** have a `SELECT` grant on:

- `Salary`

## Permission Verification

The final permission check confirmed:

    EmployeeID      → SELECT / GRANT
    EmployeeName    → SELECT / GRANT
    Department      → SELECT / GRANT
    Salary          → No SELECT GRANT

## Testing Note

The current Synapse account has additional permissions, so the `Salary` column was still accessible from the current session.

A separate restricted-user test could not be completed because `CREATE USER` was not supported in this specific environment.

The CLS configuration itself was successfully created and verified through database permission metadata.

## Project Structure

    06_CLS/
    ├── README.md
    ├── sql/
    │   └── 01_CLS_Demo_Data.sql
    └── screenshots/
        ├── 01_Employee_Data.png
        ├── 02_CLS_Role.png
        ├── 03_Column_Permissions.png
        ├── 04_CLS_Access_Test.png
        └── 05_CLS_Final_Permissions.png

## Key Learning

    Access Control → Can I access the object?
    RLS            → Which rows can I access?
    CLS            → Which columns can I access?
    Masking        → How is the value displayed?

> **CLS = Controls which columns a user or role can access.**

## Technologies

- SQL
- Azure Synapse Dedicated SQL Pool
- Column-Level Security
- Database Roles
- Column Permissions
- Git
- GitHub