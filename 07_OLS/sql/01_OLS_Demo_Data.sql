
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