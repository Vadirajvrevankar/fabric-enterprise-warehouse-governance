CREATE TABLE warehouse.DimDate
(
    DateKey BIGINT,
    FullDate DATE,
    Day INT,
    Month INT,
    MonthName VARCHAR(20),
    Quarter INT,
    Year INT
);

INSERT INTO warehouse.DimDate
(
    DateKey,
    FullDate,
    Day,
    Month,
    MonthName,
    Quarter,
    Year
)
SELECT
    CAST(CONVERT(VARCHAR(8), FullDate, 112) AS BIGINT) AS DateKey,
    FullDate,
    DAY(FullDate) AS Day,
    MONTH(FullDate) AS Month,
    DATENAME(MONTH, FullDate) AS MonthName,
    DATEPART(QUARTER, FullDate) AS Quarter,
    YEAR(FullDate) AS Year
FROM
(
    SELECT DISTINCT OrderDate AS FullDate
    FROM staging.Orders
) d;

-- Validation
SELECT COUNT(*) AS DateCount
FROM warehouse.DimDate;

SELECT *
FROM warehouse.DimDate
ORDER BY FullDate;