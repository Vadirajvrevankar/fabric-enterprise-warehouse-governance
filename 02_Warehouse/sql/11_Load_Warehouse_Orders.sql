-- 02_Data_Warehouse
-- Step 11: Load Orders from staging to warehouse

INSERT INTO warehouse.Orders
SELECT
    OrderID,
    CustomerID,
    ProductID,
    OrderDate,
    Quantity,
    Amount
FROM staging.Orders;

-- Verify
SELECT *
FROM warehouse.Orders;
