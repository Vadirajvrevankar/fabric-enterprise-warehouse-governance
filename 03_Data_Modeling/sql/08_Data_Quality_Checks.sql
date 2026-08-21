-- 08_Data_Quality_Checks.sql

-- 1. Duplicate OrderID check
SELECT OrderID, COUNT(*) AS OrderCount
FROM staging.Orders
GROUP BY OrderID
HAVING COUNT(*) > 1;

-- 2. NULL check for important Order columns
SELECT
    COUNT(*) AS TotalRows,
    COUNT(OrderID) AS OrderID_Count,
    COUNT(CustomerID) AS CustomerID_Count,
    COUNT(ProductID) AS ProductID_Count,
    COUNT(OrderDate) AS OrderDate_Count,
    COUNT(Quantity) AS Quantity_Count,
    COUNT(Amount) AS Amount_Count
FROM staging.Orders;

-- 3. Invalid Quantity check
SELECT COUNT(*) AS InvalidQuantityRows
FROM staging.Orders
WHERE Quantity <= 0;

-- 4. Invalid Sales Amount check
SELECT COUNT(*) AS InvalidAmountRows
FROM staging.Orders
WHERE Amount <= 0;

-- 5. Invalid Customer reference check
SELECT COUNT(*) AS InvalidCustomerReferences
FROM staging.Orders o
LEFT JOIN staging.Customers c
    ON o.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 6. Invalid Product reference check
SELECT COUNT(*) AS InvalidProductReferences
FROM staging.Orders o
LEFT JOIN staging.Products p
    ON o.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- 7. Invalid Date reference check
SELECT COUNT(*) AS InvalidDateReferences
FROM staging.Orders o
LEFT JOIN warehouse.DimDate d
    ON o.OrderDate = d.FullDate
WHERE d.FullDate IS NULL;
