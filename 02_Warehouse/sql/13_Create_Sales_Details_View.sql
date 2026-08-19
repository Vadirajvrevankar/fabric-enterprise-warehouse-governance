-- 02_Data_Warehouse
-- Step 13: Create / Update Sales Details View
-- Target: EnterpriseWarehouse

CREATE OR ALTER VIEW warehouse.vw_SalesDetails
AS
SELECT
    o.OrderID,
    c.CustomerName,
    c.Region,
    p.ProductName,
    p.Category,
    o.OrderDate,
    o.Quantity,
    o.Amount
FROM warehouse.Orders o
JOIN warehouse.Customers c
    ON o.CustomerID = c.CustomerID
JOIN warehouse.Products p
    ON o.ProductID = p.ProductID;

-- Verify the view
SELECT *
FROM warehouse.vw_SalesDetails;