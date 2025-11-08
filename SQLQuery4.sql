create table Employees (
empname nvarchar(50),
empid INT primary key Identity(1,1),
depID INT foreign key references department(depid)
drop table Employees



create table Department
DepID INT foreign key identity(1,1),
depname nvarchar(50))

insert into department 
select ('HR')
union all

alter table [employee]
add constraint []
foreign key [  ]
references []
on delete []
on update []

SELECT 
    f.name AS foreign_key_name,
    OBJECT_NAME(f.parent_object_id) AS table_name,
    COL_NAME(fc.parent_object_id, fc.parent_column_id) AS column_name,
    OBJECT_NAME(f.referenced_object_id) AS referenced_table
FROM sys.foreign_keys AS f
INNER JOIN sys.foreign_key_columns AS fc 
    ON f.object_id = fc.constraint_object_id
WHERE OBJECT_NAME(f.parent_object_id) = 'employees';


ALTER TABLE employees
add constraint FK_emp_dep
foreign key depID
references department (depid)
on delete set null
on update no action
delete from department where
depid=1
update department
SET IDENTITY_INSERT Departmant ON;


cascade
SET NULL
SET DEFAULT
no action
