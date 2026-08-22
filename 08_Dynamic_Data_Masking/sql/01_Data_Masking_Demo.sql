
-- DATA MASKING
-- Step 1: Create Demo Customer Data


CREATE TABLE warehouse.MaskingCustomerDemo
(
    CustomerID INT,
    CustomerName VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    Salary DECIMAL(12,2)
);

--Insert
INSERT INTO warehouse.MaskingCustomerDemo
(
    CustomerID,
    CustomerName,
    PhoneNumber,
    Email,
    Salary
)
VALUES
(101, 'Rahul', '9876543210', 'rahul@gmail.com', 80000),
(102, 'Priya', '9876543211', 'priya@gmail.com', 70000),
(103, 'Kiran', '9876543212', 'kiran@gmail.com', 75000);


--verify
SELECT *
FROM warehouse.MaskingCustomerDemo;




-- Step 2: Configure Dynamic Data Masking


ALTER TABLE warehouse.MaskingCustomerDemo
ALTER COLUMN PhoneNumber
ADD MASKED WITH (FUNCTION = 'default()');


-- Verify Masking Configuration

SELECT
    c.name AS ColumnName,
    c.is_masked,
    c.masking_function
FROM sys.masked_columns AS c
WHERE c.object_id = OBJECT_ID('warehouse.MaskingCustomerDemo');