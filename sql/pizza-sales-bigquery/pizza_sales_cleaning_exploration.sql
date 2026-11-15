-- Snapshot of the table

SELECT * FROM `keen-phalanx-396514.BigQueryDemo.pizzasales` LIMIT 10;

--------------- Uniqe category of the features ---------------

-- Distinct Quantity
SELECT 
  DISTINCT quantity
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`;

-- Unique Pizza Size
SELECT 
  DISTINCT pizza_size
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`;

-- Unique Pizza Category
SELECT 
  DISTINCT pizza_category
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`;

-- Unique Pizza Name
SELECT 
  DISTINCT pizza_name
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`;

-- Unique Pizza ingredients
SELECT 
  DISTINCT pizza_ingredients
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`;


--------------- Data Cleaning ---------------

-- See Columns Length
SELECT
  count(*) as col_number 
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`;

-- See duplicate value
select
   pizza_id,
   count(*) as duplicate_value
from `keen-phalanx-396514.BigQueryDemo.pizzasales`
group by pizza_id
having count(*)>1;

-- Check Null value
select
    *
from `keen-phalanx-396514.BigQueryDemo.pizzasales`
where pizza_id is null;


--------------- Data Exploration ---------------
SELECT
   ROUND(sum(total_price),0) as Revenue,
   ROUND(sum(total_price)/count(distinct order_id),0) as Avg_order_value,
   sum(quantity) as total_pizza_sold,
   count(distinct order_id) as Total_Order,
   sum(quantity)/count(distinct order_id) as Avg_pizza_per_Order
from `keen-phalanx-396514.BigQueryDemo.pizzasales`;

-- Daily Trend for Total Order
select
    FORMAT_DATE('%A', order_date) as day_name,
    count(distinct order_id) as Total_order
from `keen-phalanx-396514.BigQueryDemo.pizzasales`
group by 1
order by Total_order desc;

-- Hourly  Trend for Total Order
SELECT
    EXTRACT(HOUR FROM order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS Total_orders
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`
GROUP BY order_hour
ORDER BY Total_orders DESC;


-- Percentage of Sales by Pizza Category
SELECT 
  pizza_category,
  round(sum(total_price),0) as total_sale,
  round(sum(total_price)/(select sum(total_price) FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`)*100,2) as pct
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`
group by pizza_category
order by total_sale desc;

-- Percentage of Sales by Pizza Size
SELECT 
  pizza_size,
  round(sum(total_price),0) as total_sale,
  round(sum(total_price)/(select sum(total_price) FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`)*100,2) as pct
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`
group by pizza_size
order by total_sale desc;

-- Total Pizza Sold by pizza category.
select
    pizza_category,
    sum(quantity) as Total_sold
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`
group by pizza_category
order by Total_sold desc;


-- Top 5 Best Sellers by Total Pizza Sold.pizza_name_id
select
    pizza_name,
    sum(quantity) as Total_sold
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`
group by pizza_name
order by Total_sold desc
limit 5;

-- Wrost 5 Best Sellers by Total Pizza Sold.pizza_name_id
select
    pizza_name,
    sum(quantity) as Total_sold
FROM `keen-phalanx-396514.BigQueryDemo.pizzasales`
group by pizza_name
order by Total_sold asc
limit 5;
