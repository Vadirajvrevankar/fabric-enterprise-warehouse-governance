-- Mirroring test: INSERT

INSERT INTO Customers (CustomerID, CustomerName, Region)
VALUES (4, 'Kiran', 'East');

SELECT * FROM Customers WHERE CustomerID = 4;
