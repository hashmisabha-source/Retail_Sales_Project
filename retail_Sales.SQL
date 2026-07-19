-- ============================================
-- Retail Sales Analysis Project
-- Author : Sabika Bano
-- Database : PostgreSQL
-- ============================================

-- ===========================
-- 1. View Dataset
-- ===========================

SELECT *
FROM retail_sales;

-- ===========================
-- 2. Total Orders
-- ===========================

SELECT COUNT(*) AS Total_Orders
FROM retail_sales;

-- ===========================
-- 3. Total Sales
-- ===========================

SELECT SUM("Sales") AS Total_Sales
FROM retail_sales;

-- ===========================
-- 4. Total Profit
-- ===========================

SELECT SUM("Profit") AS Total_Profit
FROM retail_sales;

-- ===========================
-- 5. Average Sales
-- ===========================

SELECT ROUND(AVG("Sales"),2) AS Average_Sales
FROM retail_sales;

-- ===========================
-- 6. Average Profit
-- ===========================

SELECT ROUND(AVG("Profit"),2) AS Average_Profit
FROM retail_sales;

-- ===========================
-- 7. Total Quantity Sold
-- ===========================

SELECT SUM("Quantity") AS Total_Quantity
FROM retail_sales;

-- ===========================
-- 8. Sales by Category
-- ===========================

SELECT
"Category",
SUM("Sales") AS Total_Sales
FROM retail_sales
GROUP BY "Category"
ORDER BY Total_Sales DESC;

-- ===========================
-- 9. Profit by Category
-- ===========================

SELECT
"Category",
SUM("Profit") AS Total_Profit
FROM retail_sales
GROUP BY "Category"
ORDER BY Total_Profit DESC;

-- ===========================
-- 10. Sales by Region
-- ===========================

SELECT
"Region",
SUM("Sales") AS Total_Sales
FROM retail_sales
GROUP BY "Region"
ORDER BY Total_Sales DESC;

-- ===========================
-- 11. Sales by City
-- ===========================

SELECT
"City",
SUM("Sales") AS Total_Sales
FROM retail_sales
GROUP BY "City"
ORDER BY Total_Sales DESC;

-- ===========================
-- 12. Top 10 Highest Sales Orders
-- ===========================

SELECT *
FROM retail_sales
ORDER BY "Sales" DESC
LIMIT 10;

-- ===========================
-- 13. Top 10 Profitable Orders
-- ===========================

SELECT *
FROM retail_sales
ORDER BY "Profit" DESC
LIMIT 10;

-- ===========================
-- 14. Sales by SalesPerson
-- ===========================

SELECT
"SalesPerson",
SUM("Sales") AS Total_Sales
FROM retail_sales
GROUP BY "SalesPerson"
ORDER BY Total_Sales DESC;

-- ===========================
-- 15. Profit by SalesPerson
-- ===========================

SELECT
"SalesPerson",
SUM("Profit") AS Total_Profit
FROM retail_sales
GROUP BY "SalesPerson"
ORDER BY Total_Profit DESC;

-- ===========================
-- 16. Monthly Sales
-- ===========================

SELECT
TO_CHAR("OrderDate",'Month') AS Month,
SUM("Sales") AS Total_Sales
FROM retail_sales
GROUP BY Month
ORDER BY Total_Sales DESC;

-- ===========================
-- 17. Top SalesPerson using RANK()
-- ===========================

SELECT
"SalesPerson",
SUM("Sales") AS Total_Sales,
RANK() OVER(
ORDER BY SUM("Sales") DESC
) AS Sales_Rank
FROM retail_sales
GROUP BY "SalesPerson";

-- ===========================
-- 18. Top Profit using DENSE_RANK()
-- ===========================

SELECT
"SalesPerson",
SUM("Profit") AS Total_Profit,
DENSE_RANK() OVER(
ORDER BY SUM("Profit") DESC
) AS Profit_Rank
FROM retail_sales
GROUP BY "SalesPerson";

-- ===========================
-- 19. Highest Selling Product in each Category
-- ===========================

WITH Highest_Selling AS
(
SELECT
"Category",
"Product",
"Sales",
ROW_NUMBER() OVER(
PARTITION BY "Category"
ORDER BY "Sales" DESC
) AS Row_Num
FROM retail_sales
)

SELECT *
FROM Highest_Selling
WHERE Row_Num = 1;

-- ===========================
-- 20. Create View
-- ===========================

CREATE OR REPLACE VIEW SalesPerson_Profit AS

SELECT
"SalesPerson",
SUM("Profit") AS Total_Profit
FROM retail_sales
GROUP BY "SalesPerson";

SELECT *
FROM SalesPerson_Profit
ORDER BY Total_Profit DESC;