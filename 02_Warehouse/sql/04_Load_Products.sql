-- 02_Data_Warehouse
-- Step 04: Load Products from the Fabric Mirrored Database
-- Target: EnterpriseWarehouse

INSERT INTO staging.Products
SELECT
    ProductID,
    ProductName,
    Category,
    Price
FROM ECommerceDB_Mirror.dbo.Products;

-- Verify loaded data
SELECT *
FROM staging.Products;
