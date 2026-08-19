-- 02_Data_Warehouse
-- Step 17: Data Quality Check
-- Target: EnterpriseWarehouse
-- Purpose:
-- Verify that every Order references a valid Customer and Product.

SELECT
    o.OrderID,
    o.CustomerID,
    o.ProductID
FROM warehouse.Orders o
LEFT JOIN warehouse.Customers c
    ON o.CustomerID = c.CustomerID
LEFT JOIN warehouse.Products p
    ON o.ProductID = p.ProductID
WHERE c.CustomerID IS NULL
   OR p.ProductID IS NULL;

-- Expected result:
-- No rows = all Order CustomerID and ProductID references are valid.
