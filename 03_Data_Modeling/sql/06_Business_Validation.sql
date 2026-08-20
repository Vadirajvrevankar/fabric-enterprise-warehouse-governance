-- 06_Business_Validation.sql
-- Validate that business measures are preserved from staging to FactSales.

-- 1. Total Sales - Source
SELECT SUM(Amount) AS StagingTotalSales
FROM staging.Orders;

-- 2. Total Sales - Fact
SELECT SUM(SalesAmount) AS FactTotalSales
FROM warehouse.FactSales;

-- 3. Total Quantity - Source
SELECT SUM(Quantity) AS StagingTotalQuantity
FROM staging.Orders;

-- 4. Total Quantity - Fact
SELECT SUM(Quantity) AS FactTotalQuantity
FROM warehouse.FactSales;

-- Expected:
-- StagingTotalSales  = 4,116,800.00
-- FactTotalSales     = 4,116,800.00
-- StagingTotalQty    = 245
-- FactTotalQty       = 245
