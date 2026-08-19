-- 02_Data_Warehouse
-- Step 08: Create warehouse Products table
-- Target: EnterpriseWarehouse

CREATE TABLE warehouse.Products
(
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
