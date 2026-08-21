# Row-Level Security (RLS)

## Overview

This project demonstrates Row-Level Security (RLS) using Azure Synapse Dedicated SQL Pool.

RLS restricts which rows a user can access based on a security rule.

## What Was Implemented

- Created a sales demo table
- Created a security mapping table
- Mapped the current user to a region
- Created an RLS predicate function
- Created and enabled an RLS security policy
- Tested North region access
- Tested South region access
- Restored the user mapping to North
- Verified the final RLS result

## RLS Flow

```text
Current User
     ↓
Security Mapping
     ↓
User → Region
     ↓
RLS Predicate
     ↓
Sales Table
     ↓
Authorized Rows Only


North User
    ↓
RLS
    ↓
North rows only


South User
    ↓
RLS
    ↓
South rows only


Demo Tables
Sales Table

warehouse.RLSSalesDemo

Contains:

OrderID
CustomerName
Region
SalesAmount
Security Mapping

warehouse.RLSSecurityMapping

Maps users to their authorized regions.



screenshots/
├── 01_Sales_Data.png
├── 02_Security_Mapping.png
├── 03_North_Access.png
└── 04_South_Access.png
