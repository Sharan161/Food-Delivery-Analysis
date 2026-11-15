use food_delivery;

-- Count of rows all tables
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM restaurants;
SELECT COUNT(*) FROM riders;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM deliveries;

--                                             Table orders audits
-- check all NULLs in orders
SELECT COUNT(*) AS total_rows,
SUM(order_id IS NULL) AS order_id,
SUM(customer_id IS NULL) AS customer_id,
SUM(restaurant_id IS NULL) AS restaurant_id,
SUM(order_item IS NULL) AS order_item,
SUM(order_date IS NULL) AS order_date,
SUM(order_time IS NULL) AS order_time,
SUM(order_status IS NULL) AS order_status,
SUM(total_amount IS NULL) AS total_amount 
FROM orders;

-- checks empty string
SELECT COUNT(*) AS total_rows,
SUM(order_id ='') AS order_id,
SUM(customer_id  ='') AS customer_id,
SUM(restaurant_id ='') AS restaurant_id,
SUM(order_item  ='') AS order_item,
SUM(order_date  ='') AS order_date,
SUM(order_time  ='') AS order_time,
SUM(order_status  ='') AS order_status,
SUM(total_amount  ='') AS total_amount 
FROM orders;
-- Check duplicates
SELECT COUNT(*) AS total_rows,
COUNT(DISTINCT order_id) AS unique_order_ids
FROM orders;

-- check relations
SELECT    COUNT(*) AS total_orders,
COUNT(DISTINCT customer_id) AS unique_order_customers
FROM orders;

SELECT COUNT(*) AS unmatched_orders FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS unmatched_orders FROM orders o
LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

select * from orders;

-- checks invalid amounts
select count(total_amount) from orders
where total_amount < 0;

-- checks invalid status
SELECT COUNT(*) FROM orders
WHERE order_status = 'completed'
OR order_status = 'Not Fulfilled';

-- checks in valid date and time
SELECT MIN(order_date) AS earliest_date, MAX(order_date) AS latest_date
FROM orders;

SELECT COUNT(*) AS future_dates FROM orders
WHERE order_date > NOW();

select * from orders;
SELECT MIN(order_time) AS earliest_time,MAX(order_time) AS latest_time
FROM orders;

-- checks format
SELECT order_status, COUNT(*) AS city_count FROM orders
GROUP BY order_status ORDER BY order_status;


--                                             Table customers audits

select * from customers;
-- checks null values
select count(*),SUM(customer_id IS NULL),SUM(reg_date IS NULL) 
from customers;

-- checks empty string
select count(*),SUM(customer_id =''),SUM(reg_date ='') 
from customers;

-- checks duplicate
select count(*),count(distinct customer_id) from customers;

-- checks date validation
SELECT MIN(reg_date) ,MAX(reg_date) 
FROM customers;

SELECT count(*) FROM customers
WHERE reg_date > CURDATE();

--                                Table deliveries audits
select * from deliveries;

-- checks delivery status
SELECT COUNT(*) FROM deliveries
WHERE delivery_status = 'delivered'
OR delivery_status = 'Not delivered'
or delivery_status = 'order' ;

-- checks null values
SELECT COUNT(*) ,
SUM(delivery_id IS NULL),
SUM(order_id IS NULL),
SUM(delivery_status IS NULL) ,
SUM(delivery_time IS NULL) ,
SUM(rider_id IS NULL) 
FROM deliveries;

-- checks empty string
SELECT COUNT(*) ,
SUM(delivery_id =''),
SUM(order_id =''),
SUM(delivery_status ='') ,
SUM(delivery_time ='') ,
SUM(rider_id ='') 
FROM deliveries;

select SUM(delivery_time =''),delivery_status from deliveries
group by delivery_status;
 
SELECT delivery_status,
COUNT(*) AS total_rows,
SUM(delivery_time = '') AS empty_time,
SUM(delivery_time <> '') AS filled_time
FROM deliveries GROUP BY delivery_status;
 
 -- check relations
 select count(*) from deliveries d
 left join orders o on d.order_id = o.order_id
 where d.order_id is null;
 
-- checks format
SELECT delivery_status, COUNT(*) AS city_count FROM deliveries
GROUP BY delivery_status ORDER BY delivery_status;
 
 --                                Table restaurants audits
 
 select * from restaurants;
 
 -- check duplicate
 select count(*),count(distinct restaurant_id) from restaurants;
 
 -- check null values
select count(*),
SUM(restaurant_id IS NULL),
SUM(restaurant_name IS NULL),
SUM(city IS NULL) ,
SUM(opening_hours IS NULL) FROM restaurants;

-- checks empty string
select count(*),
SUM(restaurant_id =''),
SUM(restaurant_name =''),
SUM(city ='') ,
SUM(opening_hours ='') FROM restaurants;

-- check format
select city from  restaurants
group by city order by city;

-- checks valid time
select min(opening_hours),max(opening_hours) from restaurants;

select opening_hours from restaurants;

 --                                Table riders audits

select * from riders;

-- check duplicate
select count(*),count(distinct rider_id) from riders;

-- Null value check
select count(*),
SUM(rider_id IS NULL),
SUM(rider_name IS NULL),
SUM(sign_up IS NULL)  FROM riders;

-- empty string check
select count(*),
SUM(rider_id=''),
SUM(rider_name =''),
SUM(sign_up ='')  FROM riders;

-- date check 
select min(sign_up),max(sign_up) from riders;

select count(sign_up) from riders
where sign_up >now();
