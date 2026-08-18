-- Final source verification

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

-- CustomerID 4 should return no rows after the DELETE test.
SELECT * FROM Customers WHERE CustomerID = 4;
