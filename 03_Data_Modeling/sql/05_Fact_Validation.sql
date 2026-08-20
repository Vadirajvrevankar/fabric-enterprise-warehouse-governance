-- 1. Fact row count
SELECT COUNT(*) AS FactRowCount
FROM warehouse.FactSales;


-- 2. Invalid Customer Keys
SELECT COUNT(*) AS InvalidCustomerKeys
FROM warehouse.FactSales f
LEFT JOIN warehouse.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;


-- 3. Invalid Product Keys
SELECT COUNT(*) AS InvalidProductKeys
FROM warehouse.FactSales f
LEFT JOIN warehouse.DimProduct p
    ON f.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;


-- 4. Invalid Date Keys
SELECT COUNT(*) AS InvalidDateKeys
FROM warehouse.FactSales f
LEFT JOIN warehouse.DimDate d
    ON f.DateKey = d.DateKey
WHERE d.DateKey IS NULL;