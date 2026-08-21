-- 09_SCD_Type_2_Customer.sql
-- SCD Type 2 demonstration using DimCustomer.
-- CustomerID = 5 changes Region from West to South.


-- 1. Add SCD Type 2 columns
ALTER TABLE warehouse.DimCustomer
ADD
    StartDate DATE,
    EndDate DATE,
    IsCurrent INT;


-- 2. Initialize existing customer records
UPDATE warehouse.DimCustomer
SET
    StartDate = '2026-06-01',
    EndDate = NULL,
    IsCurrent = 1;


-- 3. Close the old Customer 5 version
UPDATE warehouse.DimCustomer
SET
    EndDate = '2026-08-20',
    IsCurrent = 0
WHERE CustomerID = 5
  AND IsCurrent = 1;


-- 4. Insert the new Customer 5 version
-- Region changes: West -> South
INSERT INTO warehouse.DimCustomer
(
    CustomerKey,
    CustomerID,
    CustomerName,
    Region,
    StartDate,
    EndDate,
    IsCurrent
)
SELECT
    21,
    CustomerID,
    CustomerName,
    'South',
    '2026-08-21',
    NULL,
    1
FROM warehouse.DimCustomer
WHERE CustomerID = 5
  AND IsCurrent = 0;


-- 5. Verify Customer 5 history
SELECT
    CustomerID,
    COUNT(*) AS VersionCount,
    SUM(
        CASE
            WHEN IsCurrent = 1 THEN 1
            ELSE 0
        END
    ) AS CurrentVersionCount
FROM warehouse.DimCustomer
WHERE CustomerID = 5
GROUP BY CustomerID;

-- Expected:
-- CustomerID = 5
-- VersionCount = 2
-- CurrentVersionCount = 1


-- 6. View the two Customer 5 versions
SELECT
    CustomerKey,
    CustomerID,
    CustomerName,
    Region,
    StartDate,
    EndDate,
    IsCurrent
FROM warehouse.DimCustomer
WHERE CustomerID = 5
ORDER BY CustomerKey;

-- Expected:
-- CustomerKey | CustomerID | Region | StartDate  | EndDate    | IsCurrent
-- 5            | 5          | West   | 2026-06-01 | 2026-08-20 | 0
-- 21           | 5          | South  | 2026-08-21 | NULL       | 1
