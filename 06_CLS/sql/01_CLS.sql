
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