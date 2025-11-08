USE sqlcalss3;  
GO

IF OBJECT_ID('dbo.Categories') IS NULL
BEGIN
  CREATE TABLE dbo.Categories
  (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
  );
END
GO


IF OBJECT_ID('dbo.Products') IS NULL
BEGIN
  CREATE TABLE dbo.Products
  (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    CategoryID INT NULL,     
    Price DECIMAL(10,2) NULL
  );
END
GO

BULK INSERT dbo.Products
FROM 'C:\Data\products.csv'
WITH
(


USE sqlcalss3;
GO


IF OBJECT_ID('dbo.Categories') IS NULL
BEGIN
  CREATE TABLE dbo.Categories
  (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
  );
END
GO

IF OBJECT_ID('dbo.Products') IS NULL
BEGIN
  CREATE TABLE dbo.Products
  (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    CategoryID INT NULL,       
    Price DECIMAL(10,2) NULL
  );
END
GO


SELECT p.*
FROM dbo.Products p
LEFT JOIN dbo.Categories c ON p.CategoryID = c.CategoryID
WHERE p.CategoryID IS NOT NULL AND c.CategoryID IS NULL;

ALTER TABLE dbo.Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES dbo.Categories(CategoryID)
ON DELETE SET NULL   
ON UPDATE NO ACTION;
GO


SELECT * FROM dbo.Products WHERE Price IS NOT NULL AND Price <= 0;

ALTER TABLE dbo.Products
ADD CONSTRAINT CHK_Products_Price_Positive CHECK (Price > 0);
GO
ALTER TABLE dbo.Products
ADD Stock INT NOT NULL CONSTRAINT DF_Products_Stock DEFAULT(0);
GO


SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price_NoNull
FROM dbo.Products;



SELECT f.name AS FKName, OBJECT_NAME(f.parent_object_id) AS ChildTable, OBJECT_NAME(f.referenced_object_id) AS ParentTable
FROM sys.foreign_keys f;

EXEC sp_help 'dbo.Products';

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'Products';

