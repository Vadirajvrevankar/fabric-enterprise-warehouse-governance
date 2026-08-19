-- 02_Data_Warehouse
-- Step 09: Load Products from staging to warehouse

INSERT INTO warehouse.Products
SELECT
    ProductID,
    ProductName,
    Category,
    Price
FROM staging.Products;

-- Verify
SELECT *
FROM warehouse.Products;
