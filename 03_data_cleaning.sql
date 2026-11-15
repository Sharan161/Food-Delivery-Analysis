use food_delivery;

-- create secondary tables 
CREATE TABLE  customers_Sc AS
SELECT * FROM customers;
CREATE TABLE deliveries_Sc AS
SELECT * FROM deliveries;
CREATE TABLE orders_Sc AS
SELECT * FROM orders;
CREATE TABLE restaurants_Sc AS
SELECT * FROM restaurants;
CREATE TABLE riders_Sc AS
SELECT * FROM riders;


-- correction in restaurants table
SELECT City, COUNT(*) AS city_count FROM restaurants_Sc
GROUP BY City ORDER BY City;
select city from  restaurants_Sc
group by city order by city;

SET SQL_SAFE_UPDATES = 0;
UPDATE restaurants_Sc
SET City = 'Bengaluru'
WHERE City = 'Bangalore';
