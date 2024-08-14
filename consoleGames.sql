select * from console_games

Platform	FirstRetailAvailability	Discontinued	UnitsSoldMillions	Comment
create table if not exists console_date(
Platform varchar(10), FirstRetailAvailability date, Discontinued date, 
UnitsSoldMillions numeric, Comment varchar
);

select * from console_date

select * from console_games

select sum(na_sales + eu_sales + jp_sales + other_sales)
from console_games

select round((sum(na_sales)/ sum(na_sales + eu_sales + jp_sales + other_sales))*100) ||'%'  
from console_games 

select concat((sum(na_sales)/ sum(na_sales + eu_sales + jp_sales + other_sales))*100,'%')  
from console_games 

/*Extract a view of the console game titles ordered by platform name in Ascending order and Year of
release in descending order*/

SELECT name, year, platform
FROM console_games
order by platform ASC, year DESC;

--For each game title extract the first four letters of the publisher's name 
SELECT name, publisher, LEFT(publisher, 4) publishersInitial
from console_games

/*Display all console platforms which were released either just before 
Black Friday or just before Christmas (in any year)*/
select * from console_date

--Black friday
SELECT firstretailavailability, to_char (firstretailavailability, 'Day'),
EXTRACT(day from firstretailavailability) days,
extract(dow FROM firstretailavailability) dow,
EXTRACT(month from firstretailavailability) months,
EXTRACT(year from firstretailavailability) years
from console_date
WHERE extract(dow FROM firstretailavailability) = 5
and EXTRACT(month from firstretailavailability) = 11
and EXTRACT(day from firstretailavailability) >= 24

--Changing character or type of output--
select to_char (firstretailavailability, 'Day')
FROM console_date

--Christmas--
SELECT firstretailavailability, to_char (firstretailavailability, 'Day'),
EXTRACT(day from firstretailavailability) days,
extract(dow FROM firstretailavailability) dow,
EXTRACT(month from firstretailavailability) months,
EXTRACT(year from firstretailavailability) years
from console_date
where EXTRACT(month from firstretailavailability) = 12
and EXTRACT(day from firstretailavailability) <= 25

select name, a.platform, genre, to_char (b.firstretailavailability, 'Day') Days,
to_char (b.firstretailavailability, 'Month') Months, 
to_char (b.firstretailavailability, 'yyyy') years
from console_games a
left join console_date b
on a.platform = b.platform
WHERE (extract(dow FROM firstretailavailability) < 5
and EXTRACT(month from firstretailavailability) = 11
and EXTRACT(day from firstretailavailability) >= 24) --Last week of November 
or (EXTRACT(month from firstretailavailability) = 12
and EXTRACT(day from firstretailavailability) between 20 and 24) --5 days to christmas

/*Order the platforms by their longevity in ascending order 
(i.e. the platform which was available for the longest at the bottom)*/

select a.name, a.genre, (b.discontinued - b.firstretailavailability) tenure
from console_games a
left join console_date b
on a.platform = b.platform
order by (b.discontinued - b.firstretailavailability) asc

select platform, (b.discontinued - b.firstretailavailability) tenure
from console_date
order by (b.discontinued - b.firstretailavailability) asc


--Provide recommendation on how to deal with missing data in the file--