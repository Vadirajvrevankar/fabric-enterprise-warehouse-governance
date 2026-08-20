CREATE TABLE warehouse.FactSales
(
    OrderID INT,
    CustomerKey BIGINT,
    ProductKey BIGINT,
    DateKey BIGINT,
    Quantity INT,
    SalesAmount DECIMAL(18,2)
);

INSERT INTO warehouse.FactSales
(
    OrderID,
    CustomerKey,
    ProductKey,
    DateKey,
    Quantity,
    SalesAmount
)
SELECT
    o.OrderID,
    c.CustomerKey,
    p.ProductKey,
    d.DateKey,
    o.Quantity,
    o.Amount
FROM staging.Orders o
INNER JOIN warehouse.DimCustomer c
    ON o.CustomerID = c.CustomerID
INNER JOIN warehouse.DimProduct p
    ON o.ProductID = p.ProductID
INNER JOIN warehouse.DimDate d
    ON o.OrderDate = d.FullDate;