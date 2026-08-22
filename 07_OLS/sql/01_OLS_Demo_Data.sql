
-- OBJECT-LEVEL SECURITY (OLS)
-- Step 1: Create Demo Objects and Data


-- Create Sales Table

CREATE TABLE warehouse.OLSSalesDemo
(
    SaleID INT,
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    SalesAmount DECIMAL(12,2)
);

-- Create Payroll Table

CREATE TABLE warehouse.OLSPayrollDemo
(
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Salary DECIMAL(12,2)
);

-- Insert Sales Data

INSERT INTO warehouse.OLSSalesDemo
(
    SaleID,
    CustomerName,
    Region,
    SalesAmount
)
VALUES
(1001, 'Rahul', 'North', 50000),
(1002, 'Priya', 'South', 60000),
(1003, 'Kiran', 'West', 70000);

-- Insert Payroll Data

INSERT INTO warehouse.OLSPayrollDemo
(
    EmployeeID,
    EmployeeName,
    Salary
)
VALUES
(1, 'Rahul', 80000),
(2, 'Priya', 70000),
(3, 'Kiran', 75000);

-- Verify Sales Data

SELECT *
FROM warehouse.OLSSalesDemo;

-- Verify Payroll Data

SELECT *
FROM warehouse.OLSPayrollDemo;

-- Step 2: Create OLS Security Role

CREATE ROLE OLSAnalyst;

-- Verify Role

SELECT
    name,
    type_desc
FROM sys.database_principals
WHERE name = 'OLSAnalyst';



-- STEP 3: Grant Object-Level Access


-- Grant SELECT access to Sales table

GRANT SELECT
ON warehouse.OLSSalesDemo
TO OLSAnalyst;


-- Verify Object Permission

SELECT
    dp.name AS RoleName,
    p.permission_name,
    p.state_desc,
    OBJECT_SCHEMA_NAME(p.major_id) AS SchemaName,
    OBJECT_NAME(p.major_id) AS ObjectName
FROM sys.database_permissions p
JOIN sys.database_principals dp
    ON p.grantee_principal_id = dp.principal_id
WHERE dp.name = 'OLSAnalyst';

-- STEP 4: Verify OLS Object Permissions


SELECT
    dp.name AS RoleName,
    p.permission_name,
    p.state_desc,
    OBJECT_SCHEMA_NAME(p.major_id) AS SchemaName,
    OBJECT_NAME(p.major_id) AS ObjectName
FROM sys.database_permissions p
JOIN sys.database_principals dp
    ON p.grantee_principal_id = dp.principal_id
WHERE dp.name = 'OLSAnalyst'
ORDER BY ObjectName;



-- STEP 5: OLS Access Test


-- Test Sales Object
-- OLSAnalyst has SELECT permission on this object.

SELECT *
FROM warehouse.OLSSalesDemo;


-- Test Payroll Object
-- OLSAnalyst has NOT been granted SELECT permission
-- on this object.

SELECT *
FROM warehouse.OLSPayrollDemo;


-- NOTE:
-- The current Synapse account may still be able to access
-- OLSPayrollDemo because the current account can have
-- additional permissions.
--
-- The OLS configuration is verified separately through
-- sys.database_permissions.