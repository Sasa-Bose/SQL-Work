Create table weather
(Id int,
RecordDate date,
temperature int)

insert into weather values
(1,'2015-01-01',10),
(2,'2015-01-02',25),
(3,'2015-01-03',20),
(4,'2015-01-04',30)

Select *
from weather

-- find all dates' Id with higher temperatures compared to its previous dates (yesterday).
select w2.Id as 'Id', w2.RecordDate, w2.temperature
from weather w1
join weather w2
on w1.Id = w2.Id -1
where DATEDIFF(day,w1.RecordDate,w2.RecordDate)= 1
and w1.temperature < w2.temperature

		