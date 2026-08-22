
-- Column-Level Security (CLS)
-- Step 1: Create Demo Employee Data


CREATE TABLE warehouse.CLSEmployeeDemo
(
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(12,2)
);

INSERT INTO warehouse.CLSEmployeeDemo
(
    EmployeeID,
    EmployeeName,
    Department,
    Salary
)
VALUES
(1, 'Rahul', 'Data Engineering', 80000),
(2, 'Priya', 'Data Analytics', 70000),
(3, 'Kiran', 'Finance', 75000),
(4, 'Anita', 'HR', 65000);

-- Verify demo data
SELECT *
FROM warehouse.CLSEmployeeDemo;


-- CLS Step 2: Create Security Role

CREATE ROLE CLSAnalyst;

-- Verify Role

SELECT
    name,
    type_desc
FROM sys.database_principals
WHERE name = 'CLSAnalyst';


-- Step 3: Grant SELECT on non-sensitive columns

GRANT SELECT
(
    EmployeeID,
    EmployeeName,
    Department
)
ON warehouse.CLSEmployeeDemo
TO CLSAnalyst;

-- Step 3: Verify permissions

SELECT
    dp.name AS RoleName,
    p.permission_name,
    p.state_desc
FROM sys.database_permissions p
JOIN sys.database_principals dp
    ON p.grantee_principal_id = dp.principal_id
WHERE dp.name = 'CLSAnalyst';

-- Step 3: Verify permissions

SELECT
    dp.name AS RoleName,
    p.permission_name,
    p.state_desc,
    c.name AS ColumnName
FROM sys.database_permissions p
JOIN sys.database_principals dp
    ON p.grantee_principal_id = dp.principal_id
LEFT JOIN sys.columns c
    ON p.major_id = c.object_id
   AND p.minor_id = c.column_id
WHERE dp.name = 'CLSAnalyst';



-- Step 4: CLS Access Test


-- Test allowed columns

SELECT
    EmployeeID,
    EmployeeName,
    Department
FROM warehouse.CLSEmployeeDemo;


-- Test sensitive column

SELECT
    Salary
FROM warehouse.CLSEmployeeDemo;