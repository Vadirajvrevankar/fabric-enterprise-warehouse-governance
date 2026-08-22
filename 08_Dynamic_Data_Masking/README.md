# Dynamic Data Masking (DDM)

## Overview
This project demonstrates Dynamic Data Masking (DDM) using Azure Synapse Dedicated SQL Pool. Data Masking protects sensitive information by controlling how sensitive values are displayed to users while keeping the underlying data unchanged.

## What Was Implemented
- Created a demo customer table
- Inserted sample customer data
- Identified `PhoneNumber` as sensitive data
- Applied Dynamic Data Masking to `PhoneNumber`
- Used the `default()` masking function
- Verified the masking configuration using `sys.masked_columns`

## Masking Flow
`MaskingCustomerDemo → PhoneNumber → Dynamic Data Masking → default() → Masked value for affected users`

## Demo Table
`warehouse.MaskingCustomerDemo`

| CustomerID | CustomerName | PhoneNumber | Email | Salary |
|---|---|---|---|---:|
| 101 | Rahul | 9876543210 | rahul@gmail.com | 80000 |
| 102 | Priya | 9876543211 | priya@gmail.com | 70000 |
| 103 | Kiran | 9876543212 | kiran@gmail.com | 75000 |

## Masked Column
`PhoneNumber → MASKED ✅`

Masking configuration: `ALTER TABLE warehouse.MaskingCustomerDemo ALTER COLUMN PhoneNumber ADD MASKED WITH (FUNCTION = 'default()');`

## Verification
The masking configuration was verified using `sys.masked_columns`.

Expected result: `PhoneNumber → is_masked = 1`

## Testing Note
The current Synapse account has elevated privileges and can see the original `PhoneNumber` value. The masking configuration was successfully verified using `sys.masked_columns`. A separate non-privileged user test was not performed because the current Synapse environment does not support the required user-context testing approach.

## Key Learning
`OLS → Which OBJECT can I access?`  
`RLS → Which ROWS can I access?`  
`CLS → Which COLUMNS can I access?`  
`Masking → How is the VALUE displayed?`  
`Encryption → How is the DATA cryptographically protected?`

> **Data Masking controls how sensitive data is displayed without changing the underlying stored value.**

## Project Structure
```text
09_Data_Masking/
├── README.md
├── sql/
│   └── 01_Data_Masking_Demo.sql
└── screenshots/
    ├── 01_Masking_Demo_Data.png
    └── 02_Masking_Definition.png 
