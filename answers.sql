QUESTION ONE ANSWER:
-- Step 1: Create database if it does not exist
CREATE DATABASE IF NOT EXISTS ProductDetail;

-- Step 2: Use the database
USE ProductDetail;

-- Step 3: Create original table
CREATE TABLE IF NOT EXISTS ProductDetailRaw (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Step 4: Insert sample data
INSERT INTO ProductDetailRaw (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 5: Transform into 1NF
-- We’ll split the comma-separated values into separate rows
-- Using a recursive CTE (MySQL 8.0+)
WITH RECURSIVE SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS Rest
    FROM ProductDetailRaw

    UNION ALL

    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Rest, ',', 1)) AS Product,
        SUBSTRING(Rest, LENGTH(SUBSTRING_INDEX(Rest, ',', 1)) + 2)
    FROM SplitProducts
    WHERE Rest <> ''
)
SELECT OrderID, CustomerName, Product
FROM SplitProducts
WHERE Product <> '';


QUESTION TWO ANSWER: 



