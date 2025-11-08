Bulk insert Employees

from 'C:\Users\Пользователь\Documents\SQL Server Management Studio 21\table.csv'

with (
 FIELDTErminator = ',',
 rowterminator = '\n',
 firstrow = 2)
 
 select * from Employees

 Select empid, firstname, lastname, phonenumber
 coalesce (phone1, phone2, phone3, 'no phone') phone,
 isnull(phone1, phone ,phone3)) phonewithisnull,
 isnull(address1, address2) as adress 
 from employees


select * from employees
-- order by address1 desc, salary asc
-- where department = 'IT'
-- where salary <50 and (address1 = 'tashkent' or address2 = 'Urgench')
-- where not salary < 50
-------where department exists in (select depname1, depname2, depname3 from dep)
-- where phone1 not like '+998 93 %'
-- where phone1 like '+998 93 %'
--where firstname like '%o%'
--where lastname like '%!_%' escape '!'
-- where username like '%$%%' escape '$'
where empid between 2 and 8
--where empid>=2 and empid <=8



update employees
set username = '@a_b'
where eimpid <8
where username like '%%%'

select distinct address1, address2 from employees
select distinct address2 from employees
select distinct address1 from employees
order by top 75 percent * from employees
total 1 000 000 limit 25 000

select avg salary distinct address1 from employees

select distinct address1 from employees

select address1, avg(salary) from employees
group by address1

select top 5 * from employees

select top 5 * from employees
order by address1 desc, firstname 
offset 5 rows fetch next 5 rows only

select * from employees
order by address1 desc, firstname

select top 5 * from employees
select top 5 * from employees
order by address1
select top 75 percent * from employees

select * from employees 
order by address1 desc, firstname
offset 5 rows fetch next 5 rows only

select * from employees
where department = 'it' and
salary > any( select salary from employees where department = 'sales')

select * from employees
where department = 'it' and
salary > all( select salary from employees where department = 'sales')

select department, salary, salary firstname from employees

where Department in ('HR') and
salary * 40 > all (select salary * 1.3 from employees where department = 'marketing')

select department, isnull(phone1, isnull(phone2, phone3)) as phone, 
firstname from employees where phone like '+998 93%'





