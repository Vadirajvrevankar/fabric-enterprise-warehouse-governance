
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