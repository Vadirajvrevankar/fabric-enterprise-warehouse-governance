-- 07_Analytical_Queries.sql

-- 1. Sales by Customer
SELECT
    c.CustomerName,
    SUM(f.SalesAmount) AS TotalSales
FROM warehouse.FactSales f
INNER JOIN warehouse.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerName
ORDER BY TotalSales DESC;


-- 2. Sales by Product
SELECT
    p.ProductName,
    SUM(f.SalesAmount) AS TotalSales
FROM warehouse.FactSales f
INNER JOIN warehouse.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


-- 3. Sales by Region
SELECT
    c.Region,
    SUM(f.SalesAmount) AS TotalSales
FROM warehouse.FactSales f
INNER JOIN warehouse.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.Region
ORDER BY TotalSales DESC;


-- 4. Sales by Month
SELECT
    d.MonthName,
    SUM(f.SalesAmount) AS TotalSales
FROM warehouse.FactSales f
INNER JOIN warehouse.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.MonthName
ORDER BY TotalSales DESC;