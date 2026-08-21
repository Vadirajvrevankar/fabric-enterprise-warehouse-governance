-- ============================================================
-- 04_Access_Control
-- Access Control Practical
-- Azure Synapse Dedicated SQL Pool
-- ============================================================

-- 1. Create Demo Table
CREATE TABLE warehouse.EmployeeSecurityDemo
(
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(12,2)
);

-- 2. Insert Demo Data
INSERT INTO warehouse.EmployeeSecurityDemo
(
    EmployeeID, EmployeeName, Department, Salary
)
VALUES
(1, 'Rahul', 'Data Engineering', 80000),
(2, 'Priya', 'Data Analytics', 70000),
(3, 'Kiran', 'Finance', 75000),
(4, 'Anita', 'HR', 65000);

-- 3. Verify Demo Data
SELECT *
FROM warehouse.EmployeeSecurityDemo;

-- 4. Create Custom Database Role
CREATE ROLE SalesReader;

-- 5. Grant SELECT Permission
GRANT SELECT
ON warehouse.EmployeeSecurityDemo
TO SalesReader;

-- 6. Verify SELECT Permission
SELECT
    dp.name AS RoleName,
    p.permission_name,
    p.state_desc
FROM sys.database_permissions p
JOIN sys.database_principals dp
    ON p.grantee_principal_id = dp.principal_id
WHERE dp.name = 'SalesReader';

-- 7. Grant INSERT Permission
GRANT INSERT
ON warehouse.EmployeeSecurityDemo
TO SalesReader;

-- 8. Verify INSERT Permission
SELECT
    dp.name AS RoleName,
    p.permission_name,
    p.state_desc
FROM sys.database_permissions p
JOIN sys.database_principals dp
    ON p.grantee_principal_id = dp.principal_id
WHERE dp.name = 'SalesReader';

-- 9. Revoke INSERT Permission
REVOKE INSERT
ON warehouse.EmployeeSecurityDemo
FROM SalesReader;

-- 10. Deny DELETE Permission
DENY DELETE
ON warehouse.EmployeeSecurityDemo
TO SalesReader;

-- 11. Final Permission Verification
SELECT
    dp.name AS RoleName,
    p.permission_name,
    p.state_desc
FROM sys.database_permissions p
JOIN sys.database_principals dp
    ON p.grantee_principal_id = dp.principal_id
WHERE dp.name = 'SalesReader';

-- Expected final result:
-- SalesReader | SELECT | GRANT
-- SalesReader | DELETE | DENY

-- NOTE:
-- Real-user testing is not included because CREATE USER
-- is not supported by the current SQL editor/connection.
