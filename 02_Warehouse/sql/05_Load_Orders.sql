-- 02_Data_Warehouse
-- Step 05: Load Orders from the Fabric Mirrored Database
-- Target: EnterpriseWarehouse

INSERT INTO staging.Orders
SELECT
    OrderID,
    CustomerID,
    ProductID,
    OrderDate,
    Quantity,
    Amount
FROM ECommerceDB_Mirror.dbo.Orders;

-- Verify loaded data
SELECT *
FROM staging.Orders;
