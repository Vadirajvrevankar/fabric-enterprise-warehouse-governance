SELECT
    Region,
    SUM(Amount) AS TotalSales,
    COUNT(DISTINCT CustomerName) AS CustomerCount
FROM warehouse.vw_SalesDetails
GROUP BY Region
ORDER BY TotalSales DESC;