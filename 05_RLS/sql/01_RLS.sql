-- ============================================================
-- 05_RLS
-- Row-Level Security Practical
-- Azure Synapse Dedicated SQL Pool
-- ============================================================

-- 1. Create Sales Demo Table
CREATE TABLE warehouse.RLSSalesDemo
(
    OrderID INT,
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    SalesAmount DECIMAL(12,2)
);

-- 2. Insert Sales Demo Data
INSERT INTO warehouse.RLSSalesDemo
(
    OrderID,
    CustomerName,
    Region,
    SalesAmount
)
VALUES
(1001, 'Rahul', 'North', 50000),
(1002, 'Priya', 'South', 60000),
(1003, 'Kiran', 'North', 40000),
(1004, 'Anita', 'South', 55000),
(1005, 'Arjun', 'West', 70000);

-- 3. Verify Sales Data
SELECT *
FROM warehouse.RLSSalesDemo;

-- 4. Create Security Mapping Table
CREATE TABLE warehouse.RLSSecurityMapping
(
    UserName VARCHAR(100),
    Region VARCHAR(50)
);

-- 5. Insert Security Mapping
INSERT INTO warehouse.RLSSecurityMapping
(
    UserName,
    Region
)
VALUES
('NorthUser', 'North'),
('SouthUser', 'South'),
('WestUser', 'West');

-- 6. Check Current Synapse User
SELECT SUSER_SNAME() AS CurrentUser;

-- 7. Map Current User to North
INSERT INTO warehouse.RLSSecurityMapping
(
    UserName,
    Region
)
VALUES
(
    'fabricram@re24359gmail.onmicrosoft.com',
    'North'
);

-- 8. Verify Security Mapping
SELECT *
FROM warehouse.RLSSecurityMapping;

-- 9. Create Security Schema
CREATE SCHEMA Security;

-- 10. Create RLS Predicate Function
CREATE FUNCTION Security.fn_RLS_SalesPredicate
(
    @Region VARCHAR(50)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
(
    SELECT 1 AS AccessResult
    WHERE EXISTS
    (
        SELECT 1
        FROM warehouse.RLSSecurityMapping AS M
        WHERE M.UserName = SUSER_SNAME()
          AND M.Region = @Region
    )
);

-- 11. Create RLS Security Policy
CREATE SECURITY POLICY Security.RLSSalesSecurityPolicy
ADD FILTER PREDICATE Security.fn_RLS_SalesPredicate(Region)
ON warehouse.RLSSalesDemo
WITH (STATE = ON);

-- 12. Test North Access
SELECT *
FROM warehouse.RLSSalesDemo;

-- Expected:
-- 1001 | Rahul | North | 50000
-- 1003 | Kiran | North | 40000

-- 13. Verify Visible Row Count
SELECT COUNT(*) AS VisibleRows
FROM warehouse.RLSSalesDemo;

-- Expected:
-- 2

-- 14. Temporarily Change Current User Mapping to South
UPDATE warehouse.RLSSecurityMapping
SET Region = 'South'
WHERE UserName = 'fabricram@re24359gmail.onmicrosoft.com';

-- 15. Verify South Mapping
SELECT *
FROM warehouse.RLSSecurityMapping
WHERE UserName = 'fabricram@re24359gmail.onmicrosoft.com';

-- 16. Test South Access
SELECT *
FROM warehouse.RLSSalesDemo;

-- Expected:
-- 1002 | Priya | South | 60000
-- 1004 | Anita | South | 55000

-- 17. Restore Current User Mapping to North
UPDATE warehouse.RLSSecurityMapping
SET Region = 'North'
WHERE UserName = 'fabricram@re24359gmail.onmicrosoft.com';

-- 18. Final Mapping Verification
SELECT *
FROM warehouse.RLSSecurityMapping
WHERE UserName = 'fabricram@re24359gmail.onmicrosoft.com';

-- Expected:
-- fabricram@re24359gmail.onmicrosoft.com | North

-- 19. Final RLS Verification
SELECT *
FROM warehouse.RLSSalesDemo;

-- Expected:
-- Only North rows should be visible.
