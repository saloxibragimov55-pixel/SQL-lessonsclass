
SELECT TOP (10) *
FROM Products
ORDER BY Price DESC;
GO


SELECT EmployeeID,
       COALESCE(FirstName, LastName) AS NameOrSurname
FROM Employees;
GO


SELECT DISTINCT Category, Price
FROM Products;
GO


SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40)
   OR DepartmentName = 'Marketing';
GO


SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
GO


SELECT *
FROM Products
WHERE Price <= 1000
  AND StockQuantity > 50
ORDER BY StockQuantity ASC;
GO


SELECT *
FROM Products
WHERE ProductName LIKE '%e%';
GO

/* 8) Employees who work in HR, IT or Finance (IN) */
SELECT *
FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');
GO

/* 9) Customers ordered by City ASC, PostalCode DESC */
SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;
GO

-- ==========================
-- HARD-LEVEL TASKS
-- ==========================

/* Hard 1) Top 5 products with highest sales.
   Option A: if Products table has SaleAmount column:
*/
SELECT TOP (5) ProductID, ProductName, SaleAmount
FROM Products
ORDER BY SaleAmount DESC;
GO

/* Option B: if sales are in separate Sales table (Sales: OrderID, ProductID, Quantity, Price)
   then aggregate total sales per product and take top 5:
*/
-- SELECT TOP (5) p.ProductID, p.ProductName, SUM(s.Quantity * s.Price) AS TotalSales
-- FROM Products p
-- JOIN Sales s ON s.ProductID = p.ProductID
-- GROUP BY p.ProductID, p.ProductName
-- ORDER BY TotalSales DESC;
-- GO

/* Hard 2) Combine FirstName and LastName into FullName (select-only) */
SELECT EmployeeID,
       CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;
GO

/* Hard 3) DISTINCT on 3 columns: Category, ProductName, Price for Price > 50 */
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;
GO

/* Hard 4) Products whose Price < 10% of average price of all products */
SELECT *
FROM Products
WHERE Price < 0.10 * (
    SELECT AVG(CAST(Price AS FLOAT)) FROM Products
);
GO

/* Hard 5) Employees whose Age < 30 AND DepartmentName is HR or IT */
SELECT *
FROM Employees
WHERE Age < 30
  AND DepartmentName IN ('HR', 'IT');
GO

/* Hard 6) Customers whose Email contains '@gmail.com' (case-insensitive using LOWER) */
SELECT *
FROM Customers
WHERE LOWER(Email) LIKE '%@gmail.com%';
GO

/* Hard 7) Employees whose Salary is greater than ALL employees in 'Sales' department */
SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE DepartmentName = 'Sales'
);
GO

/* Safer alternative for Hard 7: greater than MAX salary in Sales
   (handles case when Sales department has no employees by using ISNULL -> 0)
*/
SELECT *
FROM Employees
WHERE Salary > (
    SELECT ISNULL(MAX(Salary), 0) FROM Employees WHERE DepartmentName = 'Sales'
);
GO

/* Hard 8) Orders placed in the last 180 days using BETWEEN and the latest date in Orders table.
   We use MAX(OrderDate) as "LATEST_DATE in the table".
*/
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(day, -180, (SELECT MAX(OrderDate) FROM Orders))
                    AND (SELECT MAX(OrderDate) FROM Orders);
GO

