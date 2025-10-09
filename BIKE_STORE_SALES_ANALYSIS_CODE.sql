-- DATA ANALYSIS PROJECT FOR Bike Store Relational Database.

USE bikestore;

SHOW DATABASES;
USE bikestore;   
SHOW TABLES;

SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM products LIMIT 10;

SELECT * FROM brands;
SELECT * FROM categories;
SELECT * FROM staffs;
SELECT * FROM customers;
SELECT * FROM stocks;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM stores;

-- GET THE LIST OF CUSTOMERS AND THERE EMAIL IDS

SELECT EMAIL,FIRST_NAME,LAST_NAME
FROM CUSTOMERS;

-- GET THE LIST OF FIRST 10 CUSTOMERS AND THERE EMAIL IDS

SELECT EMAIL,FIRST_NAME,LAST_NAME
FROM CUSTOMERS
LIMIT 10 OFFSET 2;

-- WE WANT TO MERGE EACH CUSTOMER'S NAME INTO SINGLE COLUMN THAT CONTAINS FIRST NAME,THEN A SPACE,AND THEN LAST NAME

SELECT *,CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME
FROM CUSTOMERS;

SELECT *,LOWER(FIRST_NAME),UPPER(EMAIL)
FROM CUSTOMERS;

SELECT *,CONCAT(FIRST_NAME," ",SUBSTR(LAST_NAME,1,1)) AS USER_NAME
FROM CUSTOMERS;

-- Total Sale by Store

SELECT stores_id, SUM(quantity * list_price) AS total_sales
FROM order_items
GROUP BY stores_id;

-- TOTAL REVENUE FROM ALL ORDERS.
-- (It adds up all (quantity × price) from your order_items table to find the total money (revenue) your bike store earned.)

SELECT 
ROUND(SUM(quantity * list_price), 2) AS total_revenue        
FROM order_items;

-- REVENUE BY STORE
-- (This query calculates how much total money each store earned by adding up all product sales from its orders.

SELECT s.store_name, 
SUM(oi.quantity * oi.list_price) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.store_name;

-- REVENUE BY PRODUCT (Shows which products made the most sales.)

SELECT p.product_name, 
SUM(oi.quantity * oi.list_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

-- REVENUE BY MONTH (Shows how much money was earned every month.)

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, 
SUM(oi.quantity * oi.list_price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- REVENUE BY CATEGORIES (Shows which product categories earned the most.)

SELECT c.category_name, 
SUM(oi.quantity * oi.list_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;

-- REVENUE BY STAFFS (Shows which employee generated the most sales.)

SELECT CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
SUM(oi.quantity * oi.list_price) AS revenue
FROM staffs s
JOIN orders o ON s.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY staff_name;

-- TOP 5 BEST-SELLING PRODUCTS

SELECT product_name, SUM(quantity) AS total_sold
FROM order_items
JOIN products USING(product_id)
GROUP BY product_name
ORDER BY total_sold DESC
LIMIT 5;

-- TOTAL SELES PER STORE.

SELECT store_name, SUM(quantity * list_price) AS total_sales
FROM order_items
JOIN orders USING(order_id)
JOIN stores USING(store_id)
GROUP BY store_name
ORDER BY total_sales DESC;

-- TOTAL CELLS BY CATEGORY.

SELECT category_name, SUM(order_items.quantity * order_items.list_price) AS total_sales
FROM order_items
JOIN products USING(product_id)
JOIN categories USING(category_id)
GROUP BY category_name
ORDER BY total_sales DESC;

-- Top 5 customers by total amount spent (Shows top 5 customers who spent the most)

SELECT CONCAT(first_name, ' ', last_name) AS customer_name,
SUM(order_items.quantity * order_items.list_price) AS total_spent
FROM customers
JOIN orders USING(customer_id)
JOIN order_items USING(order_id)
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- MONTHLY SALES TREND (Total sales for each month)

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
SUM(order_items.quantity * order_items.list_price) AS total_sales
FROM orders
JOIN order_items USING(order_id)
GROUP BY month
ORDER BY month;

-- STAFFS PERFORMANCE BY SALES (Shows total sales made by each staff member)

SELECT first_name, last_name,
SUM(order_items.quantity * order_items.list_price) AS total_sales
FROM staffs
JOIN orders USING(staff_id)
JOIN order_items USING(order_id)
GROUP BY first_name, last_name
ORDER BY total_sales DESC;

-- TOTAL SALES BY BRAND (Shows which brand earned the most revenue.)

SELECT brand_name,
SUM(order_items.quantity * order_items.list_price) AS total_sales
FROM order_items
JOIN products USING(product_id)
JOIN brands USING(brand_id)
GROUP BY brand_name
ORDER BY total_sales DESC;

-- TOTAL STOCK Quantity by Brand (Shows how many products of each brand are in stock across all stores.)

SELECT brand_name,
SUM(stocks.quantity) AS total_stock
FROM stocks
JOIN products USING(product_id)
JOIN brands USING(brand_id)
GROUP BY brand_name
ORDER BY total_stock DESC;

-- Stock Quantity by Store (Shows how many products are in stock in each store.)

SELECT store_name,
SUM(quantity) AS total_stock
FROM stocks
JOIN stores USING(store_id)
GROUP BY store_name
ORDER BY total_stock DESC;

-- Where should we open new stores or focus advertising based on customer concentration? (The majority of people in this database are concentrated in New York)

SELECT c.state, COUNT(c.customer_id) AS Number_of_people 
FROM customers c 
GROUP BY 
    c.state 
ORDER BY 
    Number_of_people DESC; 
    
-- Identifies how many customers are new and how many are returning via a subquery for all three stores.
    
SELECT s.store_name,
SUM(CASE WHEN o.order_date = first_orders.first_order_date THEN 1 ELSE 0 END) AS new_customers,
SUM(CASE WHEN o.order_date <> first_orders.first_order_date THEN 1 ELSE 0 END) AS returning_customers
FROM orders o
JOIN stores s USING(store_id)
JOIN (
    SELECT customer_id, store_id, MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id, store_id
) AS first_orders
USING(customer_id, store_id)
GROUP BY s.store_name;

-- Which brands drive our revenue and deserve better placement/promotion in stores?

SELECT brand_name,
SUM(order_items.quantity * order_items.list_price) AS total_revenue
FROM order_items
JOIN products USING(product_id)
JOIN brands USING(brand_id)
GROUP BY brand_name
ORDER BY total_revenue DESC;

-- top 5 revenue-generating brands.

SELECT brand_name,
SUM(order_items.quantity * order_items.list_price) AS total_revenue
FROM order_items
JOIN products USING(product_id)
JOIN brands USING(brand_id)
GROUP BY brand_name
ORDER BY total_revenue DESC
LIMIT 5;

-- to find the best-selling products so you can consider bundling or featuring them.

SELECT products.product_name,
       SUM(order_items.quantity) AS total_sold,
       SUM(order_items.quantity * order_items.list_price) AS total_revenue
FROM order_items
JOIN products USING(product_id)
GROUP BY products.product_name
ORDER BY total_sold DESC
LIMIT 10;

-- to find most popular product types (categories) to help adjust inventory.

SELECT categories.category_name,
SUM(order_items.quantity) AS total_sold,
SUM(order_items.quantity * order_items.list_price) AS total_revenue
FROM order_items
JOIN products USING(product_id)
JOIN categories USING(category_id)
GROUP BY categories.category_name
ORDER BY total_sold DESC;

-- to find staff performance per store, so you can identify who to reward or train based on revenue contribution.

SELECT s.store_name,
CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
SUM(oi.quantity * oi.list_price) AS total_revenue
FROM staffs st
JOIN orders o ON st.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.store_name, staff_name
ORDER BY s.store_name, total_revenue DESC;

-- To find underperforming stores and analyze potential actions like promotions or openings/closures, we can look at total revenue per store.

SELECT s.store_name,
SUM(oi.quantity * oi.list_price) AS total_revenue,
COUNT(DISTINCT o.order_id) AS total_orders,
COUNT(DISTINCT o.customer_id) AS total_customers
FROM stores s
JOIN orders o ON s.store_id = o.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_name
ORDER BY total_revenue ASC;

-- To find which stores need attention regarding stock, we can look at the stock levels per store.(Low stock may indicate replenishment is needed, while high stock may indicate overstock)

SELECT s.store_name,
SUM(stocks.quantity) AS total_stock
FROM stores s
JOIN stocks ON s.store_id = stocks.store_id
GROUP BY s.store_name
ORDER BY total_stock ASC;

-- To determine peak seasons and when to run sales or launch new products, we can analyze monthly or seasonal sales trends.

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
SUM(oi.quantity * oi.list_price) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY total_sales DESC;

-- To check year-over-year growth and evaluate the effectiveness of strategic efforts, we can analyze total sales per year.

SELECT YEAR(o.order_date) AS year,
SUM(oi.quantity * oi.list_price) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year ASC;

-- To find repeat customers and evaluate loyalty programs, we can count customers who have placed more than one order.

SELECT 
    COUNT(DISTINCT customer_id) AS repeat_customers
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS repeated;

-- To identify VIP customers (high-value customers who contribute the most revenue) and plan rewards or exclusive offers, we can look at total spending per customer.

SELECT c.customer_id,
SUM(oi.quantity * oi.list_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;




    