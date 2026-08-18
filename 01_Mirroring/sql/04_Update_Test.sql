-- Mirroring test: UPDATE

UPDATE Customers
SET Region = 'Central'
WHERE CustomerID = 4;

SELECT * FROM Customers WHERE CustomerID = 4;
