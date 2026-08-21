

# Access Control

## Overview

This project demonstrates database Access Control using roles and permissions in Azure Synapse Dedicated SQL Pool.

## What Was Implemented

- Created a demo employee table
- Created a custom database role: `SalesReader`
- Granted `SELECT` permission
- Granted and revoked `INSERT` permission
- Denied `DELETE` permission
- Verified the final role permissions

## Access Control Flow

```text
SalesReader
     │
     ├── SELECT → GRANT ✅
     │
     └── DELETE → DENY ❌

     Final Permission Result


     SalesReader | SELECT | GRANT
     SalesReader | DELETE | DENY


     Project Structure


     04_Access_Control/
├── README.md
├── sql/
│   └── 01_Access_Control.sql
└── screenshots/
    ├── 01_Demo_Table.png
    ├── 02_Grant_Revoke.png
    └── 03_Final_Permissions.png


Key Learning

Access Control determines who can access a database object and what actions they are allowed to perform.

The practical demonstrated:

Role Creation
     ↓
GRANT
     ↓
REVOKE
     ↓
DENY
     ↓
Permission Verification