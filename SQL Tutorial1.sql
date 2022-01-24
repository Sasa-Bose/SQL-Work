/****** SQL Tutorial ******/
insert into person values
(4, 'sasa@s.com'),
(2, 'auro@s.com'),
(3,'sasa@s.com'),
(1,'sasa@s.com')

select *
from person
-- deleting duplicate emails, but keeping only one unique email with smallest id
delete n1 from person n1, person n2
where
n1.email = n2.email and n1.id> n2.id

--select only unique email with smallest id
SELECT *
 FROM
 (
     SELECT ROW_NUMBER() OVER (PARTITION BY email ORDER BY Id) as RowNum, *
     FROM person
 ) X 
 WHERE RowNum = 1
 order by id