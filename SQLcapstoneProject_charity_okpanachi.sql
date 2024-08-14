/*Which product categories drive the biggest profits? Is this the same across store
locations?*/
SELECT * FROM products
SELECT "Product_Category", MAX(profit) AS max_profit
FROM products
GROUP BY "Product_Category"
ORDER BY max_profit DESC;

SELECT * FROM stores

SELECT "Store_Location", "Product_Category", 
MAX(profit) AS max_profit FROM products 
JOIN sales ON products."Product_ID" = sales."Product_ID"
JOIN stores ON sales."Store_ID" = stores."Store_ID"
GROUP BY "Store_Location", "Product_Category"
ORDER BY MAX(profit) DESC; 


--How much money is tied up in inventory at the toy stores? How long will it last?
SELECT * FROM inventory
SELECT DISTINCT "Store_ID FROM inventory

SELECT * FROM stores

SELECT SUM("Stock_On_Hand") AS total_stock
FROM inventory
JOIN stores ON inventory."Store_ID" = stores."Store_ID"
WHERE "Store_Name" LIKE '%Toy%'

SELECT * FROM sales

SELECT (SUM("Stock_On_Hand") / SUM("Units")) * 30 AS days_of_inventory
FROM inventory
JOIN sales ON inventory."Product_ID" = sales."Product_ID"
JOIN stores ON inventory."Store_ID" = stores."Store_ID"
WHERE "Store_Name" LIKE '%Toy%';
--Assuming a 30-day circle--


--Are sales being lost with out of stock products at certain locations?
SELECT stores."Store_Location", COUNT("Stock_On_Hand") AS num_out_of_stock, 
SUM(sales."Units") AS total_unit_sold,
SUM(sales."Units") - COUNT(*) AS lost_sales 
FROM inventory 
LEFT JOIN sales ON inventory."Product_ID" = sales."Product_ID" 
LEFT JOIN stores ON inventory."Store_ID" = stores."Store_ID"
WHERE inventory."Stock_On_Hand" = 0
GROUP BY stores."Store_Location";

