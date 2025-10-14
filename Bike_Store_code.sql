-- Use the Bike Store database
USE bikestore;

-- List tables to confirm

SHOW TABLES;

-- Preview Data (First 10 Rows)

SELECT * FROM customers LIMIT 10;

SELECT * FROM orders LIMIT 10;

SELECT * FROM products LIMIT 10;

-- CUSTOMER OVERVIEW

-- List of all customers with emails

SELECT first_name, last_name, email FROM customers;

SELECT first_name, last_name, email FROM customers LIMIT 10;

SELECT *, CONCAT(first_name,' ',last_name) AS full_name FROM customers;

-- Lowercase first name and uppercase email

SELECT *, LOWER(first_name) AS first_name_lower, UPPER(email) AS email_upper FROM customers;

-- Usernames (First name + first letter of last name)

SELECT *, CONCAT(first_name,' ',SUBSTR(last_name,1,1)) AS user_name FROM customers;

-- TOTAL SALES & REVENUE.

-- Total sales per store

SELECT o.store_id AS store, ROUND(SUM(oi.quantity * oi.list_price),2) AS total_sales
FROM order_items oi
JOIN orders o USING(order_id)
GROUP BY o.store_id;

-- Total revenue from all orders

SELECT ROUND(SUM(quantity * list_price),2) AS total_revenue
FROM order_items;

-- Revenue by store

SELECT s.store_name, ROUND(SUM(oi.quantity * oi.list_price),2) AS revenue
FROM order_items oi
JOIN orders o USING(order_id)
JOIN stores s USING(store_id)
GROUP BY s.store_name;

-- Revenue by product

SELECT p.product_name, ROUND(SUM(oi.quantity * oi.list_price),2) AS revenue
FROM order_items oi
JOIN products p USING(product_id)
GROUP BY p.product_name;

-- Revenue by category

SELECT c.category_name, ROUND(SUM(oi.quantity * oi.list_price),2) AS revenue
FROM order_items oi
JOIN products p USING(product_id)
JOIN categories c USING(category_id)
GROUP BY c.category_name;

-- Revenue by staff

SELECT CONCAT(s.first_name,' ',s.last_name) AS staff_name, ROUND(SUM(oi.quantity * oi.list_price),2) AS revenue
FROM staffs s
JOIN orders o USING(staff_id)
JOIN order_items oi USING(order_id)
GROUP BY staff_name;

-- TOP PRODUCTS & CUSTOMERS.

 -- Top 5 best-selling products (by quantity)

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p USING(product_id)
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- Top 5 customers by total spending

SELECT CONCAT(c.first_name,' ',c.last_name) AS customer_name, ROUND(SUM(oi.quantity * oi.list_price),2) AS total_spent
FROM customers c
JOIN orders o USING(customer_id)
JOIN order_items oi USING(order_id)
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- SALES TRENDS

-- Monthly sales trend

SELECT DATE_FORMAT(order_date,'%Y-%m') AS month, ROUND(SUM(quantity * list_price),2) AS total_sales
FROM orders
JOIN order_items USING(order_id)
GROUP BY month
ORDER BY month;

-- Yearly sales trend

SELECT YEAR(order_date) AS year, ROUND(SUM(quantity * list_price),2) AS total_sales
FROM orders
JOIN order_items USING(order_id)
GROUP BY year
ORDER BY year;

-- INVENTORY vs SOLD

-- Product sold vs in stock

SELECT p.product_name, SUM(oi.quantity) AS quantity, 'Sold' AS quantity_type
FROM order_items oi
JOIN products p USING(product_id)
GROUP BY p.product_name
UNION ALL
SELECT p.product_name, SUM(st.quantity), 'In Stock'
FROM stocks st
JOIN products p USING(product_id)
GROUP BY p.product_name
ORDER BY product_name, quantity_type;

-- Customer Categories (Big, Regular, Low Spenders)

SELECT customer_id, total_order_value,
       CASE WHEN total_order_value > 20000 THEN 'Big Spender'
            WHEN total_order_value >= 5000 THEN 'Regular Spender'
            ELSE 'Low Spender' END AS spender_category
FROM (
    SELECT customer_id, ROUND(SUM(quantity * list_price * (1 - discount)),2) AS total_order_value
    FROM orders
    JOIN order_items USING(order_id)
    GROUP BY customer_id
) t;

-- Store & Staff Performance

-- Total revenue per store

SELECT s.store_name, ROUND(SUM(oi.quantity * oi.list_price),2) AS total_revenue,
       COUNT(DISTINCT o.order_id) AS total_orders,
       COUNT(DISTINCT o.customer_id) AS total_customers
FROM stores s
JOIN orders o USING(store_id)
JOIN order_items oi USING(order_id)
GROUP BY s.store_name
ORDER BY total_revenue DESC;

-- Staff performance per store

-- Staff performance per store

SELECT 
    ANY_VALUE(s.store_name) AS store_name,
    ANY_VALUE(CONCAT(st.first_name,' ',st.last_name)) AS staff_name,
    ROUND(SUM(oi.quantity * oi.list_price),2) AS total_revenue
FROM staffs st
JOIN orders o ON st.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.store_id, st.staff_id
ORDER BY store_name, total_revenue DESC;

-- BRAND & CATEGORIES ANALYSIS

-- Revenue by brand

SELECT b.brand_name, ROUND(SUM(oi.quantity * oi.list_price),2) AS total_revenue
FROM order_items oi
JOIN products p USING(product_id)
JOIN brands b USING(brand_id)
GROUP BY b.brand_name
ORDER BY total_revenue DESC;

-- Total stock by brand

SELECT b.brand_name, SUM(stocks.quantity) AS total_stock
FROM stocks
JOIN products p USING(product_id)
JOIN brands b USING(brand_id)
GROUP BY b.brand_name
ORDER BY total_stock DESC;

-- CUSTOMER INSIGHTS

-- Customers from New York

SELECT first_name, last_name, city FROM customers WHERE city = 'New York';

-- Repeat customers (more than 1 order)

SELECT COUNT(DISTINCT customer_id) AS repeat_customers
FROM (
    SELECT customer_id FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) t;


