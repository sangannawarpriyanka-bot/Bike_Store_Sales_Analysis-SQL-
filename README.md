## 🚲 Bike Store Sales Analysis Using SQL:
---

<img width="1536" height="1024" alt="two-wheeler-bike-sale-readme-banner" src="https://github.com/user-attachments/assets/e85db615-8e3b-4b15-810b-8e20523ee014" />

## 📖 Project Overview:

The purpose of this project is to analyze the operations of a bike store using SQL. The project focuses on extracting key business insights such as total revenue, sales trends, top-selling products, customer behavior, staff performance, and stock levels.

---
## 🎯Project Goal:
The goal of this project is to design and implement a relational database system for a bike store, enabling efficient management of customers, orders, products, and inventory. The project aims to provide insights into sales performance, customer behavior, and product popularity, supporting informed business decisions and improving operational efficiency.
This project analyzes a Bike Store relational database using MySQL to uncover insights about:

- Customers

- Orders & sales

- Products & categories

- Brands & inventory

- Staff performance

- Goal: Provide actionable insights for improving sales, stock management, and marketing strategies.


---

<img width="520" height="226" alt="image" src="https://github.com/user-attachments/assets/8001e661-b3ea-415b-8dc5-efcc9b42385c" />

---

## Tables in Database:

| Table Name    | Description                       |
|---------------|-----------------------------------|
| `brands`      | Brand details of products         |
| `categories`  | Product categories                |
| `customers`   | Customer details                  |
| `orders`      | Customer orders                   |
| `order_items` | Products sold in each order       |
| `products`    | Product details                   |
| `staffs`      | Store staff details               |
| `stocks`      | Stock available in stores         |
| `stores`      | Store details                     |

---
 ## 📌 Key Insights:

- Mountain bikes = top-selling category 🚵

- New York = highest customer concentration 🗽

- Top 5 products & brands generate most revenue 💰

- Staff performance varies by store

- Underperforming stores identified for promotions

## 📊 Project Features & Analysis:
---

1️⃣ Customer Insights:

- List all customers & emails ✉️

- Merge first & last names → FULL_NAME 👤

- Identify new vs returning customers

- Categorize customers: Big, Regular, Low Spenders 💰

- Identify VIP/high-value customers 🏆

2️⃣ Sales & Revenue Analysis:

- Total revenue across all stores 💵

- Revenue by store, product, category, brand

- Revenue per staff member 👩‍💼

- Monthly & yearly sales trends 📅

- Top-selling products & brands 🏅

3️⃣ Inventory Management:

- Total stock per store and brand 📦

- Compare sold vs in-stock quantities

- Identify underperforming stores or overstocked products ⚠️

4️⃣ Product & Category Insights:

- List top-priced products 💲

- Products with the most orders 🛒

- Revenue by product categories

- Top 10 most sold products

5️⃣ Staff Performance:

- Total revenue generated per staff member

- Identify top performers per store ⭐

- Staff contribution to overall store revenue

---

## 📊Key Insights:

- 💰 Top Customers: High-value repeat customers identified.

- 🚴 Best-Selling Category: Mountain bikes lead overall sales.

- 🏬 Top Stores: Urban stores generate the highest revenue.

- 🧾 Top Products: Focus areas identified for inventory and marketing.

- 👩‍💼 Staff Performance: Top sales staff ranked by revenue contribution.

- 📅 Monthly Trends: Q3 shows peak sales activity.

- 🏷️ Revenue by Brand: Most profitable brands highlighted.

- 📦 Stock Management: Balanced inventory levels across stores.

- 🧠 Business Decisions: Data-driven insights for promotions, staffing, and inventory planning.

---

## 🛠️Tools Used:

- MySQL Workbench – For creating and managing the database, writing, and executing SQL queries.

- SQL – For querying and analyzing data in the relational database.

---

## 🎯 Conclusion:

This analysis provides valuable insights into customer behavior, sales performance, and product demand trends.
It helps business stakeholders make data-driven decisions to optimize sales strategy and inventory management.

---

## Queries and Visualizations:
---

## 1] List of all customers with emails:

<img width="475" height="296" alt="image" src="https://github.com/user-attachments/assets/77f51b12-3064-4962-a246-c1a3279c8c08" />

## 2] TOTAL SALES & REVENUE:

 1] Total sales per store:
 
<img width="292" height="250" alt="image" src="https://github.com/user-attachments/assets/6abf063b-123d-4898-ba00-346e186a084f" />

 2] Total revenue from all orders:
 
<img width="292" height="250" alt="image" src="https://github.com/user-attachments/assets/c6e06e1d-a735-4798-a0bc-fc86286a3006" />

 3] Revenue by store:
 
<img width="356" height="260" alt="image" src="https://github.com/user-attachments/assets/29bfeccf-97c9-408f-a315-1ed5943f213b" />

 4] Revenue by product:
 
<img width="369" height="260" alt="image" src="https://github.com/user-attachments/assets/5d9a10b0-9b2f-4cba-9d56-ef1b9aa04b28" />

 5] Revenue by category:
 
<img width="368" height="250" alt="image" src="https://github.com/user-attachments/assets/e6aa44b4-85c3-40a8-bd01-765a556115ac" />

 6] Revenue by staff:
 
<img width="356" height="251" alt="image" src="https://github.com/user-attachments/assets/d3d1d469-ead2-4ea6-85ff-8bc837388e68" />

##  3] TOP PRODUCTS & CUSTOMERS:

 1] Top 5 best-selling products (by quantity):
 
<img width="354" height="251" alt="image" src="https://github.com/user-attachments/assets/378bff5a-bd36-4637-9284-b36839dc6a06" />

 2] Top 5 customers by total spending:
 
<img width="354" height="251" alt="image" src="https://github.com/user-attachments/assets/a9184ab1-9097-4ff3-a897-96e06d63a81c" />

## 4] SALES TRENDS:

 1]  Monthly sales trend:
 
<img width="298" height="231" alt="image" src="https://github.com/user-attachments/assets/99233041-1093-48b4-8bcf-f76b6e7dc9a7" />

 2] Yearly sales trend:
 
<img width="298" height="231" alt="image" src="https://github.com/user-attachments/assets/04736668-0f28-4cc2-8f2e-e96c4b07d5e8" />

## 5] INVENTORY vs SOLD(Product sold vs in stock):

<img width="423" height="290" alt="image" src="https://github.com/user-attachments/assets/125da796-601c-449e-86c1-5f7fe7d8287c" />

## 6] Customer Categories (Big, Regular, Low Spenders):

<img width="338" height="290" alt="image" src="https://github.com/user-attachments/assets/fe2e5b5e-d5d1-4144-8582-dfa0a8bfcf9f" />

## 7] Store & Staff Performance:

1] Total revenue per store:

<img width="232" height="430" alt="image" src="https://github.com/user-attachments/assets/c306ee00-ba15-4e52-ac54-64080aa1b8b0" />

2] Staff performance per store:

<img width="232" height="230" alt="image" src="https://github.com/user-attachments/assets/b4e808be-5524-4121-b152-8257448afbce" />

##  8] BRAND & CATEGORIES ANALYSIS:

 1] Revenue by brand:
 
<img width="196" height="135" alt="image" src="https://github.com/user-attachments/assets/290b898f-90de-4e66-8e27-a9e7642fbcd4" />

 2] Total stock by brand:
 
<img width="195" height="134" alt="image" src="https://github.com/user-attachments/assets/655792f2-e87f-4224-8bb1-7eead59d670c" />

## 9] CUSTOMER INSIGHTS:

 1] Customers from New York:
 
<img width="192" height="150" alt="image" src="https://github.com/user-attachments/assets/623a02c6-9312-4561-8c90-600f87a5d0ae" />

 2] Repeat customers (more than 1 order):
 
<img width="192" height="151" alt="image" src="https://github.com/user-attachments/assets/95eb0c48-2570-40fc-b3b7-984ce4d2dd96" />

---



