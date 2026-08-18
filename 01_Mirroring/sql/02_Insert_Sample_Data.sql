-- Initial sample data

INSERT INTO Customers (CustomerID, CustomerName, Region)
VALUES
(1, 'Ravi', 'South'),
(2, 'Anil', 'North'),
(3, 'Priya', 'West');

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(101, 'Laptop', 'IT', 60000),
(102, 'Phone', 'Mobile', 30000),
(103, 'Monitor', 'IT', 15000);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity, Amount)
VALUES
(1001, 1, 101, '2026-08-18', 1, 60000),
(1002, 2, 102, '2026-08-18', 2, 60000),
(1003, 3, 103, '2026-08-18', 1, 15000);
