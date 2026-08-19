-- 02_Data_Warehouse
-- Step 10: Create warehouse Orders table
-- Target: EnterpriseWarehouse

CREATE TABLE warehouse.Orders
(
    OrderID INT,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    Amount DECIMAL(10,2)
);
