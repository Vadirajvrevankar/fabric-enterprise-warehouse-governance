-- 02_Data_Warehouse
-- Step 12: Validate Warehouse
-- Target: EnterpriseWarehouse

-- 1. Validate warehouse row counts

SELECT
    'Customers' AS TableName,
    COUNT(*) AS TotalRows
FROM warehouse.Customers

UNION ALL

SELECT
    'Products',
    COUNT(*)
FROM warehouse.Products

UNION ALL

SELECT
    'Orders',
    COUNT(*)
FROM warehouse.Orders;


-- 2. Validate staging vs warehouse row counts

SELECT
    'Customers' AS TableName,
    (SELECT COUNT(*) FROM staging.Customers) AS StagingRows,
    (SELECT COUNT(*) FROM warehouse.Customers) AS WarehouseRows

UNION ALL

SELECT
    'Products',
    (SELECT COUNT(*) FROM staging.Products),
    (SELECT COUNT(*) FROM warehouse.Products)

UNION ALL

SELECT
    'Orders',
    (SELECT COUNT(*) FROM staging.Orders),
    (SELECT COUNT(*) FROM warehouse.Orders);
