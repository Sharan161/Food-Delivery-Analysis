use food_delivery;

select * from customers_sc;
select * from deliveries_sc;
select * from orders_sc;
select * from restaurants_sc;
select * from riders_sc;

--                                1. Overall Business Performance

-- How many total orders are there?
select count(order_id) as Total_order 
from orders_sc;

-- What is the total revenue?
select sum(total_amount) as TotalRevenue 
from orders_sc;

-- How much does an average order generate?
SELECT AVG(total_amount) AS AOV
FROM orders_sc;

-- Count of completed and notfulfilled Order status.
SELECT COUNT(order_id),order_status FROM orders
group by order_status;

-- How many orders were delivered and not deliverrd?
select delivery_status,count(delivery_id) as delivery_count from deliveries_sc
group by delivery_status;

-- What is the overall delivery success rate?
select SUM(delivery_status = 'Delivered') * 100.0 / COUNT(*) AS delivery_success_rate
FROM deliveries_sc;

-- How many unique customers placed orders?
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM orders_sc;

--                                     2. Customer Analysis

select * from customers_sc;
-- Total customers.
select count(customer_id) as TotalCustomer from customers_sc;

-- Total customers and how many customers has ordered.
select count(distinct customer_id) as OrderedCustomers,
(select count(customer_id)  from customers_sc) as TotalCustomer from orders_sc;

-- Month wise customer register count
select month(reg_date) as registration_month,
year(reg_date) as registration_year,
count(customer_id) from customers_sc
GROUP BY YEAR(reg_date), MONTH(reg_date)
ORDER BY registration_year, registration_month;

-- year wise registration
select year(reg_date) as registration_year,
count(customer_id) from customers_sc
GROUP BY YEAR(reg_date)
ORDER BY registration_year;

--                                  3. Restaurant Analysis

select * from restaurants_sc;
-- Restaurants count
select count(restaurant_id) as TotalRestaurants from restaurants_sc;

-- city wise restaurant count
select city,count(restaurant_id) as TotalRestaurants from restaurants_sc
group by city 
order by TotalRestaurants desc;

-- Which restaurants received the most orders?
select r.restaurant_id,restaurant_name,count(o.order_id) as orders from  restaurants_sc r
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.restaurant_id,r.restaurant_name
order by orders desc
limit 5;

-- Which restaurants generated the most revenue?
select r.restaurant_id,restaurant_name,sum(o.total_amount) as revenue from  restaurants_sc r
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.restaurant_id,r.restaurant_name
order by revenue desc
limit 5;

-- What is the average order value for each restaurant?
select r.restaurant_id,restaurant_name,avg(o.total_amount) as average_order_value from  restaurants_sc r
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.restaurant_id,r.restaurant_name
order by average_order_value desc
limit 5;

--                                 4. City Analysis

-- Which restaurant cities have the most unique customers placing orders?
select  r.city,count( distinct o.customer_id) as customers from restaurants_sc r 
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.city
order by customers desc;

-- Which restaurant cities received the most orders?
select  r.city,count(o.order_id) as orders from restaurants_sc r 
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.city
order by orders desc;

-- Which restaurant cities generate the most revenue?
select  r.city,sum(o.total_amount) as revenue from restaurants_sc r 
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.city
order by revenue desc;

--                    5. Delivery Analysis

select * from deliveries_sc;
-- How many deliveries were delivered and not delivered?
select delivery_status,count(order_id) as orders from deliveries_sc
group by delivery_status;

-- What percentage of deliveries were not delivered?
select SUM(delivery_status = 'Not Delivered') * 100.0 / COUNT(*) AS not_delivered_percentage
FROM deliveries_sc;

-- Which riders/persons have the most not-delivered deliveries?
select r.rider_name,count(d.delivery_status) as not_delivered from deliveries_sc d
join riders_sc r on d.rider_id = r.rider_id
where d.delivery_status = 'Not delivered'
group by rider_name
order by not_delivered desc;

-- Which cities have the most not-delivered deliveries?
select r.city,count(d.delivery_status) as not_delivered from deliveries_sc d
join orders_sc o on d.order_id = o.order_id
join restaurants_sc r on o.restaurant_id = r.restaurant_id
where d.delivery_status = 'Not Delivered'
group by r.city
order by not_delivered desc; 

-- At what time are deliveries most commonly completed?
select hour(delivery_time)  as Times,count(delivery_status) as completed_deliveries from deliveries_sc
where delivery_status = 'Delivered'
group by times
order by completed_deliveries desc;

--                 6. Rider Analysis

select * from riders_sc;
-- Which month had the most rider registrations?
SELECT COUNT(rider_id) AS rider_count,MONTH(sign_up) AS registration_month,
YEAR(sign_up) AS registration_year FROM riders_sc
GROUP BY YEAR(sign_up), MONTH(sign_up)
ORDER BY rider_count DESC
LIMIT 2;

-- Which riders completed the most deliveries?
select r.rider_name,count(d.delivery_status) as delivered from riders_sc r 
join deliveries_sc d on r.rider_id = d.rider_id
where d.delivery_status = 'Delivered'
group by r.rider_name
order by delivered  desc 
limit 2;

-- Which riders had the most not-delivered deliveries?
select r.rider_name,count(d.delivery_status) as Not_delivered from riders_sc r 
join deliveries_sc d on r.rider_id = d.rider_id
where d.delivery_status = 'Not Delivered'
group by r.rider_name
order by Not_delivered desc 
limit 2;

-- Which riders handled the most total deliveries?
select r.rider_name,count(d.delivery_status) as deliveries from riders_sc r 
join deliveries_sc d on r.rider_id = d.rider_id
group by r.rider_name
order by deliveries desc 
limit 2;

-- Which riders had the highest delivery success rate?
select r.rider_name,sum(d.delivery_status = 'Delivered')/count(d.delivery_status) * 100 as delivery_success_rate from riders_sc r 
join deliveries_sc d on r.rider_id = d.rider_id
group by r.rider_name
order by delivery_success_rate  desc 
limit 2;

-- Which riders handled the most deliveries by city?
select r.rider_name,r2.city,count(d.delivery_status) as deliveries from riders_sc r
join deliveries_sc d on r.rider_id = d.rider_id
join orders_sc o on d.order_id = o.order_id
join restaurants_sc r2 on o.restaurant_id = r2.restaurant_id
group by r.rider_name,r2.city
order by deliveries desc 
limit 2;

--                              7. Time-Based Analysis

-- Which month has the most orders?
select month(order_date) as months,year(order_date) as years,count(order_id) as orderCount from orders_sc
group by months,years
order by orderCount desc;

-- Which day of the week has the most orders?
select dayname(order_date) as Days,month(order_date) as months,year(order_date) as years,count(order_id) as orderCount from orders_sc
group by days,months,years
order by orderCount desc
limit 2;

-- At what time are orders most commonly placed?
select hour(order_time) as OrderedTime,count(order_id) as orderCount from orders_sc
group by OrderedTime
order by orderCount desc;

--  Which month generates the most revenue?
select month(order_date) as months,year(order_date) as years,sum(total_amount) as revenue from orders_sc
group by months,years
order by revenue desc;

