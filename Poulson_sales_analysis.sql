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
				where sl.State IN ("Maryland","Massachusetts","Maine","New Jersey")
					group by sl.State, Year_and_Month
						order by year(Year_and_Month), month(Year_and_Month);


                