use projects 
go 


select * from order_details;  -- order_details_id	order_id	pizza_id	quantity

select * from pizzas -- pizza_id, pizza_type_id, size, price

select * from orders  -- order_id, date, time

select * from pizza_types;  -- pizza_type_id, name, category, ingredients

- Retrieve the total number of orders placed.

select count (order_id)as 'orderplaced'
from orders

--Calculate the total revenue generated from pizza sales.



SELECT SUM(TRY_CAST(price AS decimal(10, 2))) AS total_revenue 
FROM pizzas;


select cast(sum(order_details.quantity * pizzas.price) as decimal(10,2)) as 'Total Revenue'
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id

--Identify the highest-priced pizza.

SELECT top 1 pizza_types.name as 'pizza name',cast(pizzas.price as decimal(10,2)) as 'price'
from pizza_types join pizzas on  pizzas.pizza_type_id=pizza_types.pizza_type_id
order by price desc

delete from pizzas
where TRY_CAST (price as float)
IS NULL;

-- Identify the most common pizza size ordered.

select pizzas.size, count(distinct order_id) as 'No of Orders'
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by count(distinct order_id) desc

-- List the top 5 most ordered pizza types along with their quantities.

select top 5 pizza_types.name as 'Pizza', sum(cast(quantity as decimal(10,2))) as'Total Ordered'
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name 
order by sum(cast(quantity as decimal(10,2))) desc


-- Join the necessary tables to find the total quantity of each pizza category ordered.
--sum qantitiy ,category,orderid


select top 5 pizza_types.category, sum(cast(quantity as decimal(10,2))) as 'Total Quantity Ordered'
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.category 
order by sum(cast(quantity as decimal(10,2))) desc

-- find the category-wise distribution of pizzas

select category, count (distinct pizza_type_id) as no_of_pizza
from pizza_types
group by category
order by no_of_pizza

-- Determine the top 3 most ordered pizza types based on revenue.
--orderid - pizza type - price 
select top 3 pizza_types.name, sum(pizzas.price*order_details.quantity) as revenue
from pizzas join order_details
on pizzas.pizza_id =order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name
order by Revenue desc

SELECT TOP 3 
    pizza_types.name, 
    SUM(CAST(pizzas.price AS DECIMAL(10, 2)) * order_details.quantity) AS revenue
FROM 
    pizzas 
JOIN 
    order_details ON pizzas.pizza_id = order_details.pizza_id
JOIN 
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY 
    pizza_types.name
ORDER BY 
    revenue DESC;









