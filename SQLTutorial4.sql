create table Employee
( id int,
salary int)


--If there is no second highest salary, the query should report null.
--report the second highest salary from the Employee table.
--case 1 (input)
insert into Employee values
--(1,100),
(2,200),
(3,300)

select top 3 *
from Employee


select Distinct salary 
from Employee
order by salary desc
offset 1 rows --skips 1 no's of rows
fetch next 1 rows only 

--CASE 2(no second highest values)


insert into Employee values
(1,100)


select 
(
select Distinct salary 
from Employee
order by salary desc
offset 0 rows --skips 1 no's of rows
fetch next 1 rows only
)as SecondHighestSalary

--nth highest salary
create function NthHighestSalary(@n int) returns int as
begin
return(
select 
(
select Distinct salary 
from Employee
order by salary desc
offset @n-1 rows --skips 1 no's of rows
fetch next 1 rows only
)as SecondHighestSalary
)
end