
IF OBJECT_ID('dbo.Products','U') IS NULL
BEGIN
    CREATE TABLE dbo.Products (
        ProductID INT IDENTITY(1,1) PRIMARY KEY,
        ProductName NVARCHAR(100),
        Category NVARCHAR(50),
        Price DECIMAL(10,2),
        StockQuantity INT,
        SaleAmount DECIMAL(18,2) NULL
    );
END
GO


IF OBJECT_ID('dbo.Employees','U') IS NULL
BEGIN
    CREATE TABLE dbo.Employees (
        EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
        FirstName NVARCHAR(50) NULL,
        LastName NVARCHAR(50) NULL,
        Age INT,
        DepartmentName NVARCHAR(50),
        Salary DECIMAL(18,2)
    );
END
GO


IF OBJECT_ID('dbo.Customers','U') IS NULL
BEGIN
    CREATE TABLE dbo.Customers (
        CustomerID INT IDENTITY(1,1) PRIMARY KEY,
        CustomerName NVARCHAR(100),
        City NVARCHAR(50),
        PostalCode NVARCHAR(20),
        Email NVARCHAR(100)
    );
END
GO


IF OBJECT_ID('dbo.Orders','U') IS NULL
BEGIN
    CREATE TABLE dbo.Orders (
        OrderID INT IDENTITY(1,1) PRIMARY KEY,
        OrderDate DATETIME,
        CustomerID INT NULL
    );
END
GO


IF OBJECT_ID('dbo.Sales','U') IS NULL
BEGIN
    CREATE TABLE dbo.Sales (
        SaleID INT IDENTITY(1,1) PRIMARY KEY,
        ProductID INT,
        Quantity INT,
        Price DECIMAL(10,2)  -- цена за единицу
    );
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.Products)
BEGIN
    INSERT INTO dbo.Products (ProductName, Category, Price, StockQuantity, SaleAmount)
    VALUES
    ('Iron Sword','Weapons', 1200.00, 25, 5000.00),
    ('Wooden Shield','Armor', 450.00, 120, 1500.00),
    ('Health Potion','Consumables', 50.00, 500, 2000.00),
    ('Mana Potion','Consumables', 55.00, 300, 1800.00),
    ('Steel Helmet','Armor', 800.00, 60, 900.00),
    ('Longbow','Weapons', 700.00, 80, 2100.00),
    ('Herbs Pack','Consumables', 8.00, 400, 320.00),
    ('Golden Ring','Jewelry', 5000.00, 5, 7500.00),
    ('Boots of Speed','Armor', 2500.00, 15, 1200.00),
    ('Dagger','Weapons', 90.00, 200, 600.00);
END
GO

-- Employees
IF NOT EXISTS (SELECT 1 FROM dbo.Employees)
BEGIN
    INSERT INTO dbo.Employees (FirstName, LastName, Age, DepartmentName, Salary)
    VALUES
    ('Alex','Ivanov', 28, 'IT', 2400.00),
    (NULL,'Sidorov', 35, 'Marketing', 1800.00),
    ('Maria','Petrova', 32, 'HR', 2000.00),
    ('John','Doe', 45, 'Sales', 3200.00),
    ('Anna',NULL, 26, 'IT', 1900.00),
    ('Sergey','Kuznetsov', 29, 'Finance', 2100.00),
    ('Elena','Smirnova', 31, 'Sales', 1700.00),
    ('Oleg','Miller', 24, 'HR', 1500.00),
    ('Nina','Orlova', 38, 'Marketing', 2300.00),
    ('Pavel','Novak', 41, 'Finance', 2800.00);
END
GO

-- Customers
IF NOT EXISTS (SELECT 1 FROM dbo.Customers)
BEGIN
    INSERT INTO dbo.Customers (CustomerName, City, PostalCode, Email)
    VALUES
    ('Ivan Petrov','Tashkent','100000','ivan.petrov@gmail.com'),
    ('Sara Lee','Samarkand','200100','sara.lee@yahoo.com'),
    ('Bob Marley','Bukhara','300200','bob@gmail.com'),
    ('Khan Timur','Tashkent','100001','timur@mail.ru'),
    ('Lola Smith','Khiva','400300','lola.smith@gmail.com');
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.Orders)
BEGIN
    INSERT INTO dbo.Orders (OrderDate, CustomerID)
    VALUES
    (DATEADD(day, -10, GETDATE()), 1),   -- 10 дней назад
    (DATEADD(day, -90, GETDATE()), 2),   -- 90 дней назад
    (DATEADD(day, -200, GETDATE()), 3),  -- 200 дней назад
    (DATEADD(day, -30, GETDATE()), 4),   -- 30 дней назад
    (DATEADD(day, -170, GETDATE()), 5);  -- 170 дней назад
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.Sales)
BEGIN
    INSERT INTO dbo.Sales (ProductID, Quantity, Price)
    VALUES
    (1, 2, 1200.00),
    (2, 10, 450.00),
    (3, 50, 50.00),
    (4, 30, 55.00),
    (6, 12, 700.00),
    (8, 1, 5000.00),
    (9, 3, 2500.00),
    (10, 7, 90.00);
END
GO

-- ========================================
-- Выполнение запросов (Medium + Hard)
-- Результаты появятся по очереди
-- ========================================

/* 1) Top 10 products by Price DESC */
PRINT '1) Top 10 products by Price DESC';
SELECT TOP (10) *
FROM dbo.Products
ORDER BY Price DESC;
GO

/* 2) COALESCE FirstName or LastName */
PRINT '2) COALESCE(FirstName, LastName)';
SELECT EmployeeID,
       COALESCE(FirstName, LastName) AS NameOrSurname
FROM dbo.Employees;
GO

/* 3) DISTINCT Category and Price */
PRINT '3) DISTINCT Category, Price';
SELECT DISTINCT Category, Price
FROM dbo.Products;
GO

/* 4) Employees age between 30 and 40 OR Department = Marketing */
PRINT '4) Employees age BETWEEN 30 AND 40 OR Department = Marketing';
SELECT *
FROM dbo.Employees
WHERE (Age BETWEEN 30 AND 40)
   OR DepartmentName = 'Marketing';
GO

/* 5) OFFSET-FETCH rows 11..20 ordered by Salary DESC */
PRINT '5) OFFSET-FETCH rows 11..20 by Salary DESC';
SELECT *
FROM dbo.Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
GO

/* 6) Products Price <= 1000 and StockQuantity > 50 order by StockQuantity ASC */
PRINT '6) Products with Price <=1000 and StockQuantity >50 ordered by StockQuantity';
SELECT *
FROM dbo.Products
WHERE Price <= 1000
  AND StockQuantity > 50
ORDER BY StockQuantity ASC;
GO

/* 7) Products whose ProductName contains letter ''e'' */
PRINT '7) Products where ProductName LIKE ''%e%''';
SELECT *
FROM dbo.Products
WHERE ProductName LIKE '%e%';
GO

/* 8) Employees in HR, IT or Finance (IN) */
PRINT '8) Employees WHERE DepartmentName IN (''HR'',''IT'',''Finance'')';
SELECT *
FROM dbo.Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');
GO

/* 9) Customers ordered by City ASC, PostalCode DESC */
PRINT '9) Customers ORDER BY City ASC, PostalCode DESC';
SELECT *
FROM dbo.Customers
ORDER BY City ASC, PostalCode DESC;
GO

-- ==========================
-- Hard-level
-- ==========================

/* Hard 1) Top 5 products with highest sales using aggregated Sales table */
PRINT 'Hard 1) Top 5 products by TotalSales (aggregated from Sales)';
SELECT TOP (5) p.ProductID, p.ProductName, SUM(s.Quantity * s.Price) AS TotalSales
FROM dbo.Products p
JOIN dbo.Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales DESC;
GO

/* Hard 2) Combine FirstName and LastName into FullName */
PRINT 'Hard 2) CONCAT(FirstName, '' '', LastName) AS FullName';
SELECT EmployeeID,
       CONCAT(FirstName, ' ', LastName) AS FullName
FROM dbo.Employees;
GO

/* Hard 3) DISTINCT on three columns where Price > 50 */
PRINT 'Hard 3) DISTINCT Category, ProductName, Price WHERE Price > 50';
SELECT DISTINCT Category, ProductName, Price
FROM dbo.Products
WHERE Price > 50;
GO

/* Hard 4) Products whose Price < 10% of average product price */
PRINT 'Hard 4) Products where Price < 10% of AVG(Price)';
SELECT *
FROM dbo.Products
WHERE Price < 0.10 * (SELECT AVG(CAST(Price AS FLOAT)) FROM dbo.Products);
GO

/* Hard 5) Employees Age < 30 AND Department HR or IT */
PRINT 'Hard 5) Employees Age < 30 AND Department IN (HR, IT)';
SELECT *
FROM dbo.Employees
WHERE Age < 30
  AND DepartmentName IN ('HR', 'IT');
GO

/* Hard 6) Customers whose Email contains '@gmail.com' (case-insensitive) */
PRINT 'Hard 6) Customers WHERE LOWER(Email) LIKE ''%@gmail.com%''';
SELECT *
FROM dbo.Customers
WHERE LOWER(Email) LIKE '%@gmail.com%';
GO

/* Hard 7) Employees with Salary > ALL salaries in Sales dept */
PRINT 'Hard 7) Employees WHERE Salary > ALL (salaries in Sales)';
SELECT *
FROM dbo.Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM dbo.Employees
    WHERE DepartmentName = 'Sales'
);
GO

/* Safer alternative (greater than MAX salary in Sales) */
PRINT 'Hard 7b) Alternative: Salary > ISNULL(MAX(Salary),0) of Sales dept';
SELECT *
FROM dbo.Employees
WHERE Salary > (
    SELECT ISNULL(MAX(Salary), 0) FROM dbo.Employees WHERE DepartmentName = 'Sales'
);
GO

/* Hard 8) Orders placed in the last 180 days relative to latest OrderDate in table */
PRINT 'Hard 8) Orders BETWEEN MAX(OrderDate)-180 days AND MAX(OrderDate)';
SELECT *
FROM dbo.Orders
WHERE OrderDate BETWEEN DATEADD(day, -180, (SELECT MAX(OrderDate) FROM dbo.Orders))
                    AND (SELECT MAX(OrderDate) FROM dbo.Orders);
GO

PRINT '--- Скрипт выполнен ---';
