QUESTION ONE ANSWER:
-- Create database if it does not exist
CREATE DATABASE IF NOT EXISTS ProductDetail;

-- Use the database
USE ProductDetail;

-- Create original table
CREATE TABLE IF NOT EXISTS ProductDetailRaw (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert sample data
INSERT INTO ProductDetailRaw (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Transform into 1NF
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

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS OrderDetail;
USE OrderDetail;

-- Drop tables if they already exist (to avoid duplicates when re-running)
DROP TABLE IF EXISTS OrderProducts;
DROP TABLE IF EXISTS Orders;

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Create OrderProducts table
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert data into OrderProducts
INSERT INTO OrderProducts (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);




