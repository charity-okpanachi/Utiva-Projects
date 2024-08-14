--Q1. Find the most common product names mentioned in the complaints.
select distinct product_name, 
	count(product_name) as productNameCount
from consumer_complaints
group by product_name order by productNameCount desc;

--Q2. Find the number of complaints submitted via each method.
select distinct submitted_via, 
	count(submitted_via)
from consumer_complaints
group by submitted_via;

--Q3. Group the complaints by the year they were received and find the count for each year.
select distinct
	extract(year from date_received) as year,
	count(extract(year from date_received)) as year_count
from consumer_complaints
group by extract(year from date_received);

--Q4. Calculate the average number of days taken by companies to respond to the complaints.
select  date_received, date_sent, date_sent - date_received as day,
	avg(date_sent - date_received) as AverageDay
from consumer_complaints 
group by date_received, date_sent;

--Q5. Identify the TOP 10 companies with the highest number of complaints.
select distinct company, 
	count(issue) as count_issue from consumer_complaints 
group by  company order by count(issue) desc
limit 10;

--Q6. Group the complaints by the company response to consumers and find the count for each category.
select distinct company_response_to_consumer,
	count(company_response_to_consumer)
from consumer_complaints 
group by company_response_to_consumer 
order by count(company_response_to_consumer) desc; 

--Q7. Find the top 10 states with the highest number of complaints.
select distinct state_name,
	count(issue) as count_issue from consumer_complaints
group by state_name order by count_issue desc
limit 10;

--Q8. Find the top 10 sub-products with the highest number of complaints.
select distinct sub_product,
	count(issue) as count_issue from consumer_complaints
group by sub_product order by count_issue desc
limit 10;

--Q9. Calculate the percentage of complaints where the consumers disputed the company's response, both for "Yes" and "No"?
select consumer_disputed, (disputed_count/sum(disputed_count))*100 as percentage 
	from (select consumer_disputed, count(consumer_disputed) as disputed_count
		from consumer_complaints
		where consumer_disputed = 'Yes' or consumer_disputed = 'No'
		group by consumer_disputed) as subquery
group by  consumer_disputed, subquery.disputed_count

--Q10. Group the complaints by the company and find the count of complaints for each company.
select distinct company, 
	count(issue) as count_of_complaints from consumer_complaints 
group by  company 
