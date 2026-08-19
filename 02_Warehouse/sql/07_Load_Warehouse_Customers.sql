-- 02_Data_Warehouse
-- Step 07: Load Customers from staging to warehouse

INSERT INTO warehouse.Customers
SELECT
    CustomerID,
    CustomerName,
    Region
FROM staging.Customers;

-- Verify
SELECT *
FROM warehouse.Customers;
