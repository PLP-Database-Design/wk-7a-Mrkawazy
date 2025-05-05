-- Create database
CREATE DATABASE week7;
USE week7;

-- Create initial table with anomalies (0NF)
CREATE TABLE ordertable(
    id INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    CustomerName VARCHAR(50),
    Products VARCHAR(50)
);

-- Insert sample data
INSERT INTO ordertable(OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop,Mouse'),
(102, 'Jane Smith', 'Tablet,Keyboard,Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 1: Remove repeating values (1NF)
ALTER TABLE ordertable
DROP COLUMN Products;

-- Step 2: Create Products table (1NF)
CREATE TABLE Products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    productName VARCHAR(100),
    Customer_ID INT
    );
-- Insert normalized product data
INSERT INTO Products(productName, Customer_ID) VALUES
('Laptop', 1),
('Mouse', 1),
('Tablet', 2),
('Keyboard', 2),
('Mouse', 2),
('Phone', 3);

-- Question 2
-- Step 1 i had to delete repeating item from the products table i.e mouse on ID->5
delete from products where id=5;

-- Step 2: Create Customers table (2NF) so that the customer table stand on its own 
CREATE TABLE Customers(
    id INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100)
);

-- Step 3: Insert Data into customer table
INSERT INTO Customers(CustomerName) VALUES 
('John Doe'),
('Jane Smith'),
('Emily Clark');

-- Step 4: Modify ordertable for 2NF (remove transitive dependency)
-- First, drop the old foreign key in Products
ALTER TABLE Products
DROP Customer_ID;

-- Drop ordertable to recreate it
Drop table ordertable;
-- Create initial table with anomalies (0NF)
CREATE TABLE ordertable(
    id INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    customer_id int,
    product_id int,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES Customers(id),
    CONSTRAINT fk_order_product FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- Insert data into ordertable
INSERT INTO ordertable(OrderID,customer_id,product_id) values
('101',1,1),
('101',1,2),
('102',2,3),
('102',2,4),
('103',3,6);