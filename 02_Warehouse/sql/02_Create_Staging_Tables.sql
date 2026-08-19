-- 02_Data_Warehouse
-- Step 01: Create staging tables
-- Target: Microsoft Fabric Warehouse
-- Warehouse: EnterpriseWarehouse

CREATE TABLE staging.Customers
(
    CustomerID INT,
    CustomerName VARCHAR(100),
    Region VARCHAR(50)
);

CREATE TABLE staging.Products
(
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE staging.Orders
(
    OrderID INT,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    Amount DECIMAL(10,2)
);
