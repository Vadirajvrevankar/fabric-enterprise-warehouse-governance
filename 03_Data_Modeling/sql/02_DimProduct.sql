-- Create and load Product Dimension

CREATE TABLE warehouse.DimProduct
(
    ProductKey BIGINT,
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(18,2)
);

INSERT INTO warehouse.DimProduct
(
    ProductKey,
    ProductID,
    ProductName,
    Category,
    Price
)
SELECT
    ROW_NUMBER() OVER (ORDER BY ProductID) AS ProductKey,
    ProductID,
    ProductName,
    Category,
    Price
FROM staging.Products;

-- Validation
SELECT COUNT(*) AS ProductCount
FROM warehouse.DimProduct;

SELECT *
FROM warehouse.DimProduct
ORDER BY ProductKey;