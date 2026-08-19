-- 02_Data_Warehouse
-- Step 14: Customer Sales Analysis
-- Target: EnterpriseWarehouse
-- Business Question:
-- How much total sales did each customer generate?

SELECT
    CustomerName,
    SUM(Amount) AS TotalSales
FROM warehouse.vw_SalesDetails
GROUP BY CustomerName
ORDER BY TotalSales DESC;
