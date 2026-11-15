--                              8. Advanced Analysis

-- Which customers have spent the most money?
select c.customer_name,sum(total_amount) as total_spent  from customers_sc c
join orders_sc o on c.customer_id = o.customer_id
group by c.customer_name
order by total_spent desc
limit 2 ;

-- Which customers placed the most orders?
select c.customer_name,count(order_id) as orders  from customers_sc c
join orders_sc o on c.customer_id = o.customer_id
group by c.customer_name
order by orders desc
limit 2 ;

-- Which restaurants have the highest average order value?
SELECT r.restaurant_name,COUNT(o.order_id) AS order_count,SUM(o.total_amount) AS revenue,
AVG(o.total_amount) AS average_order_value FROM restaurants_sc r
JOIN orders_sc o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_order_value DESC
LIMIT 5;

-- Which restaurants have an above-average order value?
select r.restaurant_name,SUM(o.total_amount) AS revenue FROM restaurants_sc r
JOIN orders_sc o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
having avg(o.total_amount) > (
SELECT AVG(total_amount) FROM orders_sc)
ORDER BY revenue DESC;

--  Which restaurants generate more revenue than the average restaurant revenue?
select r.restaurant_name,sum(o.total_amount) AS revenue FROM restaurants_sc r
JOIN orders_sc o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
having  revenue > (SELECT AVG(revenue) FROM (
        SELECT SUM(total_amount) AS revenue FROM orders_sc
        GROUP BY restaurant_id) AS restaurant_revenue )
ORDER BY revenue DESC;

-- Which riders have handled many deliveries but have a lower delivery success rate?
WITH rider_performance AS (
SELECT r.rider_id,r.rider_name,COUNT(d.delivery_id) AS total_deliveries,
SUM(d.delivery_status = 'Delivered') AS completed_deliveries,
SUM(d.delivery_status = 'Delivered') * 100.0/ COUNT(d.delivery_id) AS success_rate
FROM riders_sc r
JOIN deliveries_sc d ON r.rider_id = d.rider_id
GROUP BY r.rider_id, r.rider_name)
SELECT rider_name,total_deliveries,completed_deliveries,
ROUND(success_rate, 2) AS success_rate
FROM rider_performance
WHERE total_deliveries > (
    SELECT AVG(total_deliveries)FROM rider_performance)
    AND success_rate < (
    SELECT AVG(success_rate)FROM rider_performance)
ORDER BY total_deliveries DESC;

-- Rank restaurants by revenue within each city.
with restaurant_revenue as(
select r.restaurant_name,r.city,sum(total_amount) as revenue from  restaurants_sc r
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.restaurant_name,r.city),
restaurant_Rank as (
select restaurant_name,city,revenue,rank() over(partition by city order by revenue desc) as ranks from restaurant_revenue)
select * from restaurant_Rank;

-- Find each restaurant's percentage contribution to total revenue.
SELECT DISTINCT r.restaurant_name,
SUM(o.total_amount) OVER (PARTITION BY r.restaurant_id) AS restaurant_revenue,
SUM(o.total_amount) OVER () AS total_revenue,
SUM(o.total_amount) OVER (PARTITION BY r.restaurant_id)
/ SUM(o.total_amount) OVER () * 100 AS revenue_percentage
FROM restaurants_sc r
JOIN orders_sc o ON r.restaurant_id = o.restaurant_id;

-- Find the top 3 restaurants in each city based on revenue.
with restaurant_revenue as(
select r.restaurant_name,r.city,sum(total_amount) as revenue from  restaurants_sc r
join orders_sc o on r.restaurant_id = o.restaurant_id
group by r.restaurant_name,r.city),
restaurant_Rank as (
select restaurant_name,city,revenue,rank() over(partition by city order by revenue desc) as ranks from restaurant_revenue)
select * from restaurant_Rank
where ranks <= 3;