-- 02_Data_Warehouse
-- Step 15: Product Sales Analysis
-- Target: EnterpriseWarehouse
-- Business Question:
-- Which products generated the highest sales?

SELECT
    ProductName,
    Category,
    SUM(Amount) AS TotalSales,
    SUM(Quantity) AS TotalQuantity
FROM warehouse.vw_SalesDetails
GROUP BY
    ProductName,
    Category
ORDER BY TotalSales DESC;