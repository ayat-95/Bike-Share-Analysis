--===================================Bike_share_ Analysis ======================

select* from bike_share_yr_0
select* from bike_share_yr_1
select * from cost_table



--============KPIs==============
--Total Revenue
--Total Cost
--Total Profit 
--Avg Revenue 
-- number of Riders




--=================== Total Riders============

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1) 
select sum(riders) as Total_riders from Total_bike_share as T



--==================Total Cost =============

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  Round (sum(cogs*riders),3) as Total_cost from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr

--===============Total Profit ===============

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  Round (sum((price*riders)- cogs),2) as Total_profit from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr
--============Ave Revenue===========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  Round (avg(price* riders),2) As Avg_Revenue from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr

--==========Avg Cost ================
with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  Round (avg(cogs*riders),3) as Avg_cost from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr



--===================Analysis ==============

--=========Total Riders per year =========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  format (dteday , 'yyyy') year , sum (riders) as total_riders from Total_bike_share as T
group by  format (dteday , 'yyyy')
order by total_riders desc


--=========Total Riders per month =========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  format (dteday , 'MMMM') year , sum (riders) as total_riders from Total_bike_share as T
group by  format (dteday , 'MMMM')
order by total_riders desc


--=========Total biker per day=========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  format (dteday , 'dddd') as day , sum (riders) as total_riders from Total_bike_share as T
group by  format (dteday , 'dddd')
order by total_riders desc



--=========Total biker per hour =========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  (hr) as Hour , sum (riders) as total_riders from Total_bike_share as T
group by  hr
order by total_riders desc


--============= # of riders by rider type========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  rider_type , sum(riders)  AS number_of_Riders from Total_bike_share as T
group by rider_type

--==============Total profit by rider type===========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select  rider_type , Round (sum((price*riders)- cogs),2) as Total_profit from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr
group by rider_type


--==============Total profit per season ===========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select   
case 
when season =1 then 'winter '
when season =2 then 'spring' 
when season =3 then 'summer'
else 'autoum'
end as seasons
, Round (sum((price*riders)- cogs),2) as Total_profit from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr
group by season 
order by Total_profit

--=====================Total Profit & Total Revenue per month============


with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select   format (dteday , 'MMMM' ) as Month, (Round(sum((price*riders)- cogs),2)) as Total_profit ,Round (sum(price*riders),2) as Total_Revenue 
from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr 
group by  format (dteday , 'MMMM' )
order by format (dteday , 'MMMM' )


--=================== Number of rider& profit per weekday========== 


with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1)
select 
case 
when weekday =0 then 'sunday'
when weekday =1 then 'monday'
when weekday =0 then 'tuesday'
when weekday =0 then 'wednesday'
when weekday =0 then 'thursday'
else 'friday'
end as weekdays,
sum (riders) AS Total_Riders ,
Round (sum((price*riders)- cogs),2) as Total_profit
from Total_bike_share as T
join cost_table as c 
on T.yr=c.yr
group by weekday

--=============== Total Rider & Hum ===========

with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1) 
select riders , hum  from Total_bike_share as T
order by hum desc

--================ Total Rider by Workingday==========
with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1) 
select sum(riders) as Total_riders ,
case 
when workingday=0 then 'no'
else 'yes'
end as workingday
from Total_bike_share as T
group by workingday



--================ Total Rider by holiday==========
with Total_bike_share as (select* from bike_share_yr_0 union 
select* from bike_share_yr_1) 
select sum(riders) as Total_riders ,
case 
when holiday=0 then 'no'
else 'yes'
end as holiday
from Total_bike_share as T
group by holiday

