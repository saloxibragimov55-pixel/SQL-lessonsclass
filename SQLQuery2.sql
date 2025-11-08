Create table classrooms2 (
EmpID INT,
Name Nvarchar(50),
Salary decimal(10,2)

)

Insert into classrooms2 (EmpID, Name, Salary)
Values (1, 'Salohiddin', 6000.0);

Insert into classrooms2 Values (2, 'Maya', 5500.00);

Insert into classrooms2 (EmpID, Name, Salary)
Values 
(3, 'Charlie', 5000.00),
(4, 'Diana', 7200.00);


select * from classrooms2

UPDATE classrooms2
Set Salary = 7000
Where EmpID = 1;

delete from classrooms2
where EmpID = 2;

alter table classrooms2
alter column Name Nvarchar(100);

alter table classrooms2
add Department Nvarchar(50);

ALTER TABLE classrooms2
alter column Salary Float;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

TRUNCATE TABLE Departments;

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'IT' UNION ALL
SELECT 3, 'Finance' UNION ALL
SELECT 4, 'Sales' UNION ALL
SELECT 5, 'Management';

UPDATE classrooms2
SET Department = 'Management'
WHERE Salary > 5000;

TRUNCATE TABLE classrooms2;

alter table classrooms2
drop column Department;

EXEC sp_rename 'classrooms2', 'StaffMembers';

Drop table Departments;


Create table Products (
 ProductID INT Primary Key,
 Productname Varchar(100),
 Category Varchar(50),
 Price DECIMAL(10,2),
 Description Varchar(200)

 )

 Alter table Products
 Add constraint chk_Price CHECK (Price > 0);

 Alter table Products
 Add StockQuantity INT DEFAULT 50;

 EXEC sp_rename 'Products.Category', 'ProductCategory', 'Column';

 Insert into Products (ProductID, Productname, ProductCategory, Price, Description)
 Values
 (1, 'Laptop', 'Electronics', 1200.00, 'Gaming Laptop'),
 (2, 'Chair', 'Furniture', 150.00, 'Office Chair'),
 (3, 'Pen', 'Stationery', 2.50, 'Blue ink pen'),
 (4, 'Headphones', 'Electronics', 80.00, 'Wireless Headphones'),
 (5, 'Table', 'Furniture', 300.00, 'Woden Table');

 select * from Inventory

 Select *
 Into Products_Backup
 From Products;

 EXEC sp_rename 'Invertory', 'Inventory';

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

ALTER TABLE Inventory
DROP CONSTRAINT chk_Price;

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

Alter table Inventory
ADD Productcode INT Identity(1000,5);

Select * from Inventory



 