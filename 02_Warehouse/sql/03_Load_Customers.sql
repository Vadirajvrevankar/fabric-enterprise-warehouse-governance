-- 02_Data_Warehouse
-- Step 03: Load Customers from the Fabric Mirrored Database
-- Target: EnterpriseWarehouse

INSERT INTO staging.Customers
SELECT
    CustomerID,
    CustomerName,
    Region
FROM ECommerceDB_Mirror.dbo.Customers;

-- Verify loaded data
SELECT *
FROM staging.Customers;
