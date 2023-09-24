SELECT *
FROM [master].[dbo].[dbsamsung]

/**1**/
with
rankedcountries as (
select
Country, 
sum([Units_Sold])  as total_units_sold,
rank () over (order by sum([Units_Sold]) desc) as rankno
from [dbo].[dbsamsung]
where[Product] = ' Amarilla ' and Year = 2014
group by Country
)

Select Country, total_units_sold, rankno
from rankedcountries
where rankno < 2


select Country, Segment,
sum([Units_Sold]) as total_units_sold
from [dbo].[dbsamsung]
where[Product] = ' Amarilla ' and Year = 2014
group by Country, Segment 
order by  Segment asc


/**2**/
select Month_Name,Month_Number, Product, Segment,
avg([Sales] ) as avg_sales,
sum([Units_Sold]) as total_units_sold
from [dbo].[dbsamsung]
where [Country] = 'Mexico'and Year = 2014
group by Month_Name,Month_Number,Product, Segment
order by Month_Number asc



/**3**/

with profit as (
select [Product],Country, 
((Sales - [COGS]) / Sales * 100 )as profitmargin
from [dbo].[dbsamsung]
where Year = 2014
),

avgprofit as (
select Product, Country, 
avg (profitmargin) as avgprofitmargin
from profit
group by Product, Country
)

select Product, Country, round(avgprofitmargin,2) as profit_margin,
rank () over ( partition by Country order by avgprofitmargin desc) as rankno
from avgprofit

/**4**/
with profit as (
select [Product],Country, 
SUM([Profit]) as totalprofit
from [dbo].[dbsamsung]
where Year = 2014
group by [Product],Country
),

highestprofit as (
select Product, Country, totalprofit,
rank () over ( partition by Country order by totalprofit desc) as rankno
from profit
)
Select * from highestprofit
where rankno <= 3;



/**5**/
with profit as (
select [Product],Country, Segment, Discount_Band,
((Sales - [COGS]) / Sales * 100 )as profitmargin
from [dbo].[dbsamsung]
where Year = 2014
),

avgprofit as (
select Product, Country, Segment, Discount_Band,
AVG (profitmargin) as avgprofitmargin
from profit
group by Product, Country,Segment, Discount_Band
having AVG (profitmargin) > 0
)

select Product, Country, round(avgprofitmargin,2) as profit_margin,Segment, Discount_Band,
dense_rank () over ( partition by Country, Segment, Discount_Band order by avgprofitmargin desc) as rankno
from avgprofit 


/**6**/
select
Product, Country, Segment,
min(Discounts) AS least_non_zero_discount
from[dbo].[dbsamsung]
where Discounts > 0
group by Product, Country, Segment
order by Segment asc


/**7**/
with totalunits as (
select Country,Segment,
    sum([Units_Sold]) as totalunits
from [dbo].[dbsamsung]
group by Country,Segment
)
select Country,
    max(case when Segment = 'Channel Partners' then totalunits end) as Channel_Partner,
	max(case when Segment = 'Enterprise' then totalunits end) as Enterprise,
	max(case when Segment = 'Government' then totalunits end) as Government,
	max(case when Segment = 'Midmarket' then totalunits end) as Mid_Market,
	max(case when Segment = 'Small Business' then totalunits end) as Small_Business
from totalunits
group by Country


