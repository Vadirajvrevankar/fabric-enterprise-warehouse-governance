
-- Create and load Customer Dimension

CREATE TABLE warehouse.DimCustomer
(
    CustomerKey BIGINT,
    CustomerID INT,
    CustomerName VARCHAR(100),
    Region VARCHAR(50)
);

INSERT INTO warehouse.DimCustomer
(
    CustomerKey,
    CustomerID,
    CustomerName,
    Region
)
SELECT
    ROW_NUMBER() OVER (ORDER BY CustomerID) AS CustomerKey,
    CustomerID,
    CustomerName,
    Region
FROM staging.Customers;

-- Validation
SELECT COUNT(*) AS CustomerCount
FROM warehouse.DimCustomer;

SELECT *
FROM warehouse.DimCustomer
ORDER BY CustomerKey;
