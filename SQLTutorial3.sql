create table department
(id int,
revenue int,
month varchar(10)
)

insert into department values
(1,8000,'Jan'),
(2,9000,'Jan'),
(3,10000,'Feb'),
(1,7000,'Feb'),
(1,6000,'Mar')

select *
from department

--reformat the table such that there is a department id column and a revenue column for each month
select
    id
     , Jan as Jan_Revenue
     , Feb as Feb_Revenue
     , Mar as Mar_Revenue
     , Apr as Apr_Revenue
     , May as May_Revenue
     , Jun as Jun_Revenue
     , Jul as Jul_Revenue
     , Aug as Aug_Revenue
     , Sep as Sep_Revenue
     , Oct as Oct_Revenue
     , Nov as Nov_Revenue
     , Dec as Dec_Revenue
from 
(
    select
        id
        , revenue
        , month
    from department
) as a
pivot (sum(a.revenue)
      for month in ([Jan],[Feb],[Mar],[Apr],[May],[Jun],[Jul],[Aug],[Sep],[Oct],[Nov],[Dec])
      ) as pivot_1