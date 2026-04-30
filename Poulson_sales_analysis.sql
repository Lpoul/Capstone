-- Sales Territory: Northeast Region

select *
from management;

-- Gets all the data from the Northeast Region. 
select sl.StoreLocation, sl.Store_ID, sl.State, ss.Transaction_Date, ss.Sale_Amount
	from store_locations sl
		join store_sales ss
			on sl.Store_ID = ss.Store_ID
				where sl.State IN ("Maryland","Massachusetts","Maine","New Jersey")
					order by Sale_Amount ASC;
                    
-- Gets the Start Date, End Date and overall revenue
select min(ss.Transaction_Date) as Start_Date, max(ss.Transaction_Date) as End_Date,sum(ss.Sale_Amount) as Total_Revenue
	from store_locations sl
		join store_sales ss
			on sl.Store_ID = ss.Store_ID
				where sl.State IN ("Maryland","Massachusetts","Maine","New Jersey");
                
                
-- Gets the month by month revenue breakdown from each state in the Northeast Region
select sl.State, date_format(ss.Transaction_Date,'%Y %m') as Year_and_Month, sum(ss.Sale_Amount) as Total_Monthly_Revenue
	from store_locations sl
		join store_sales ss
			on sl.Store_ID = ss.Store_ID
				where sl.State in ("Maryland","Massachusetts","Maine","New Jersey")
					group by sl.State, Year_and_Month
						order by year(Year_and_Month), month(Year_and_Month);

-- Total price comparison of total revenue by each sales region (the use of case was used from w3schools)
select 
	case
		when sl.State in ("Maryland","Massachusetts","Maine","New Jersey") then "Northeast"
        when sl.State in ("New York","Connecticut") then "East"
        when sl.State in ("Florida","South Carolina","Texas") then "South"
        when sl.State in ("Colorado","Online Sales") then "West"
	end as Region, sum(ss.Sale_Amount) as Total_Monthly_Revenue
			from store_locations sl
				join store_sales ss
					on sl.Store_ID = ss.Store_ID
						group by Region;

-- Shows the Number of each product sold, How much the average transaction was, what product was being sold. Filtered for the Northwest region and Ordered by the most amount sold each month 
select  date_format(Transaction_Date,'%Y %m') as Year_and_Month, count(Sale_Amount) as Num_Sold, avg(Sale_Amount) as Average_Transaction , p.Product,p.Categoryid
	from store_sales ss
		join products p
			on ss.ProdNum = p.ProdNum
				join store_locations sl
					on ss.Store_ID = sl.Store_ID
						where sl.State in ("Maryland","Massachusetts","Maine","New Jersey")
							group by p.Categoryid, Year_and_Month,p.Product
								order by Year_and_Month ASC ,Num_Sold DESC;

-- This provides a ranking of the in-store sales performance by each store within the Northeast region
select ss.Store_ID, sl.State, sum(Sale_Amount) as Total_Sales_Revenue
	from store_sales ss 
		join store_locations sl
			on ss.store_ID = sl.store_ID
				where sl.State in ("Maryland","Massachusetts","Maine","New Jersey")
					group by ss.Store_ID,sl.StoreLocation,sl.State
						order by Total_Sales_Revenue DESC;
