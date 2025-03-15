CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE Warehouse (
    WarehouseID VARCHAR(50) PRIMARY KEY,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Category (
    CategoryID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    ProductID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price FLOAT NOT NULL,
    Stock INT NOT NULL,
    CategoryID VARCHAR(50),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Inventory (
    InventoryID VARCHAR(50) PRIMARY KEY,
    ProductID VARCHAR(50),
    WarehouseID VARCHAR(50),
    Quantity INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
    UNIQUE (ProductID, WarehouseID)
);

CREATE TABLE Customer (
    CustomerID VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);

CREATE TABLE Address (
    AddressID VARCHAR(50) PRIMARY KEY,
    Street VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    ZipCode VARCHAR(20) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    CustomerID VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Coupon (
    CouponID VARCHAR(50) PRIMARY KEY,
    Code VARCHAR(100) UNIQUE NOT NULL,
    DiscountValue FLOAT NOT NULL,
    ExpiryDate DATE NOT NULL
);

CREATE TABLE Discount (
    DiscountID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DiscountPercentage FLOAT NOT NULL,
    ExpiryDate DATE NOT NULL
);

CREATE TABLE `Order` (
    OrderID VARCHAR(50) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    Status VARCHAR(50) NOT NULL,
    CustomerID VARCHAR(50),
    CouponID VARCHAR(50),
    DiscountID VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID),
    FOREIGN KEY (DiscountID) REFERENCES Discount(DiscountID)
);

CREATE TABLE OrderItem (
    OrderItemID VARCHAR(50) PRIMARY KEY,
    OrderID VARCHAR(50),
    ProductID VARCHAR(50),
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Payment (
    PaymentID VARCHAR(50) PRIMARY KEY,
    OrderID VARCHAR(50),
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    Amount FLOAT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID)
);

CREATE TABLE Shipping (
    ShippingID VARCHAR(50) PRIMARY KEY,
    OrderID VARCHAR(50),
    ShipDate DATE NOT NULL,
    Carrier VARCHAR(100) NOT NULL,
    TrackingNumber VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID)
);

CREATE TABLE Review (
    ReviewID VARCHAR(50) PRIMARY KEY,
    CustomerID VARCHAR(50),
    ProductID VARCHAR(50),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Inserting Data into Tables
INSERT INTO Warehouse (WarehouseID, Location) VALUES
('W001', 'Mumbai'),
('W002', 'Delhi'),
('W003', 'Bangalore'),
('W004', 'Hyderabad'),
('W005', 'Chennai');
SELECT * FROM WAREHOUSE;

INSERT INTO Category (CategoryID, Name) VALUES
('C001', 'Electronics'),
('C002', 'Clothing'),
('C003', 'Home Decor'),
('C004', 'Books'),
('C005', 'Beauty');
SELECT * FROM CATEGORY;

INSERT INTO Product (ProductID, Name, Description, Price, Stock, CategoryID) VALUES
('P001', 'T-Shirt', 'Comfortable cotton t-shirt', 898.06, 95, 'C002'),
('P002', 'Vase', 'Ceramic vase with a minimalist touch', 893.35, 85, 'C003'),
('P003', 'Cookbook', 'Delicious recipes from around the world', 406.60, 68, 'C004'),
('P004', 'Moisturizer', 'Hydrating cream for soft skin', 248.63, 82, 'C005'),
('P005', 'Laptop', 'High-performance laptop for professionals', 132.11, 30, 'C001'),
('P006', 'Dress', 'Elegant evening dress', 309.94, 74, 'C002'),
('P007', 'Vase', 'Ceramic vase with a minimalist touch', 534.04, 12, 'C003'),
('P008', 'Textbook', 'Comprehensive material for academic studies', 982.40, 69, 'C004'),
('P009', 'Perfume', 'Long-lasting fragrance for daily use', 621.31, 28, 'C005'),
('P010', 'Headphones', 'Noise-cancelling over-ear headphones', 840.63, 70, 'C001'),
('P011', 'T-Shirt', 'Comfortable cotton t-shirt', 833.93, 69, 'C002'),
('P012', 'Rug', 'Hand-woven wool rug', 345.32, 31, 'C003'),
('P013', 'Textbook', 'Comprehensive material for academic studies', 404.77, 72, 'C004'),
('P014', 'Moisturizer', 'Hydrating cream for soft skin', 650.55, 95, 'C005'),
('P015', 'Smartphone', 'Latest model with advanced features', 184.39, 36, 'C001'),
('P016', 'T-Shirt', 'Comfortable cotton t-shirt', 904.82, 19, 'C002'),
('P017', 'Lamp', 'Adjustable desk lamp with LED light', 438.17, 56, 'C003'),
('P018', 'Biography', 'Inspiring life story of a public figure', 655.25, 69, 'C004'),
('P019', 'Lipstick', 'Matte finish with vibrant color', 629.89, 37, 'C005'),
('P020', 'Smartwatch', 'Wearable device with health tracking', 713.37, 81, 'C001');
SELECT * FROM PRODUCT;

INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Phone) VALUES
('CUST001', 'Aarav', 'Sharma', 'aarav@mail.com', '9896320196'),
('CUST002', 'Vihaan', 'Gupta', 'vihaan@mail.com', '9839905657'),
('CUST003', 'Aadhya', 'Kapoor', 'aadhya@mail.com', '9843525953'),
('CUST004', 'Ishaan', 'Verma', 'ishaan@mail.com', '9835543154'),
('CUST005', 'Riya', 'Mehta', 'riya@mail.com', '9872090049'),
('CUST006', 'Anaya', 'Singh', 'anaya@mail.com', '9840206667'),
('CUST007', 'Arjun', 'Rao', 'arjun@mail.com', '9835841261'),
('CUST008', 'Diya', 'Patel', 'diya@mail.com', '9894174252'),
('CUST009', 'Kabir', 'Chawla', 'kabir@mail.com', '9815388887'),
('CUST010', 'Sneha', 'Bhatt', 'sneha@mail.com', '9830419563');
SELECT * FROM CUSTOMER;

INSERT INTO Address (AddressID, Street, City, State, ZipCode, Country, CustomerID) VALUES
('A001', '101 MG Road', 'Mumbai', 'Maharashtra', '229060', 'India', 'CUST001'),
('A002', '202 Linking Road', 'Delhi', 'Delhi', '788479', 'India', 'CUST002'),
('A003', '303 Brigade Road', 'Bangalore', 'Karnataka', '840650', 'India', 'CUST003'),
('A004', '404 Charminar St', 'Hyderabad', 'Telangana', '648107', 'India', 'CUST004'),
('A005', '505 Marina Beach Rd', 'Chennai', 'Tamil Nadu', '780277', 'India', 'CUST005'),
('A006', '606 Connaught Place', 'Kolkata', 'West Bengal', '494451', 'India', 'CUST006'),
('A007', '707 Park Street', 'Pune', 'Maharashtra', '148158', 'India', 'CUST007'),
('A008', '808 Esplanade Road', 'Ahmedabad', 'Gujarat', '792284', 'India', 'CUST008'),
('A009', '909 Residency Road', 'Jaipur', 'Rajasthan', '226032', 'India', 'CUST009'),
('A010', '1010 Prince Anwar Shah Rd', 'Lucknow', 'Uttar Pradesh', '606711', 'India', 'CUST010');
SELECT * FROM ADDRESS;

INSERT INTO Coupon (CouponID, Code, DiscountValue, ExpiryDate) VALUES
('COUP001', 'SAVE10', 0.1, '2025-12-31'),
('COUP002', 'SAVE20', 0.2, '2026-01-01'),
('COUP003', 'SAVE30', 0.3, '2026-01-02'),
('COUP004', 'SAVE40', 0.4, '2026-01-03'),
('COUP005', 'SAVE50', 0.5, '2026-01-04');
SELECT * FROM COUPON;

INSERT INTO Discount (DiscountID, Name, DiscountPercentage, ExpiryDate) VALUES
('DISC001', 'Summer Sale', 5, '2025-06-30'),
('DISC002', 'Festive Bonanza', 10, '2025-07-01'),
('DISC003', 'Clearance Offer', 15, '2025-07-02'),
('DISC004', 'New Year Special', 20, '2025-07-03');
SELECT * FROM DISCOUNT;

INSERT INTO `Order` (OrderID, OrderDate, Status, CustomerID, CouponID, DiscountID) VALUES
('O001', '2025-01-01', 'Delivered', 'CUST001', 'COUP001', 'DISC001'),
('O002', '2025-01-02', 'Shipped', 'CUST002', 'COUP002', 'DISC002'),
('O003', '2025-01-03', 'Pending', 'CUST003', 'COUP003', 'DISC003'),
('O004', '2025-01-04', 'Cancelled', 'CUST004', 'COUP004', 'DISC004'),
('O005', '2025-01-05', 'Delivered', 'CUST005', 'COUP005', 'DISC001'),
('O006', '2025-01-06', 'Shipped', 'CUST006', 'COUP001', 'DISC002'),
('O007', '2025-01-07', 'Pending', 'CUST007', 'COUP002', 'DISC003'),
('O008', '2025-01-08', 'Cancelled', 'CUST008', 'COUP003', 'DISC004'),
('O009', '2025-01-09', 'Delivered', 'CUST009', 'COUP004', 'DISC001'),
('O010', '2025-01-10', 'Shipped', 'CUST010', 'COUP005', 'DISC002'),
('O011', '2025-01-11', 'Pending', 'CUST001', 'COUP001', 'DISC003'),
('O012', '2025-01-12', 'Cancelled', 'CUST002', 'COUP002', 'DISC004'),
('O013', '2025-01-13', 'Delivered', 'CUST003', 'COUP003', 'DISC001'),
('O014', '2025-01-14', 'Shipped', 'CUST004', 'COUP004', 'DISC002'),
('O015', '2025-01-15', 'Pending', 'CUST005', 'COUP005', 'DISC003'),
('O016', '2025-01-16', 'Cancelled', 'CUST006', 'COUP001', 'DISC004'),
('O017', '2025-01-17', 'Delivered', 'CUST007', 'COUP002', 'DISC001'),
('O018', '2025-01-18', 'Shipped', 'CUST008', 'COUP003', 'DISC002'),
('O019', '2025-01-19', 'Pending', 'CUST009', 'COUP004', 'DISC003'),
('O020', '2025-01-20', 'Cancelled', 'CUST010', 'COUP005', 'DISC004');
SELECT * FROM `Order`;

INSERT INTO OrderItem (OrderItemID, OrderID, ProductID, Quantity) VALUES
('OI001', 'O002', 'P002', 4),
('OI002', 'O003', 'P003', 2),
('OI003', 'O004', 'P004', 3),
('OI004', 'O005', 'P005', 2),
('OI005', 'O006', 'P006', 4),
('OI006', 'O007', 'P007', 2),
('OI007', 'O008', 'P008', 4),
('OI008', 'O009', 'P009', 2),
('OI009', 'O010', 'P010', 4),
('OI010', 'O011', 'P011', 2),
('OI011', 'O012', 'P012', 3),
('OI012', 'O013', 'P013', 3),
('OI013', 'O014', 'P014', 1),
('OI014', 'O015', 'P015', 2),
('OI015', 'O016', 'P016', 2),
('OI016', 'O017', 'P017', 4),
('OI017', 'O018', 'P018', 4),
('OI018', 'O019', 'P019', 2),
('OI019', 'O020', 'P020', 2),
('OI020', 'O001', 'P001', 3),
('OI021', 'O002', 'P002', 2),
('OI022', 'O003', 'P003', 4),
('OI023', 'O004', 'P004', 4),
('OI024', 'O005', 'P005', 1),
('OI025', 'O006', 'P006', 3),
('OI026', 'O007', 'P007', 3),
('OI027', 'O008', 'P008', 2),
('OI028', 'O009', 'P009', 2),
('OI029', 'O010', 'P010', 3),
('OI030', 'O011', 'P011', 4);
SELECT * FROM orderitem;

INSERT INTO Inventory (InventoryID, ProductID, WarehouseID, Quantity) VALUES
('INV001', 'P001', 'W002', 108),
('INV002', 'P002', 'W003', 145),
('INV003', 'P003', 'W004', 162),
('INV004', 'P004', 'W005', 55),
('INV005', 'P005', 'W001', 121),
('INV006', 'P006', 'W002', 152),
('INV007', 'P007', 'W003', 71),
('INV008', 'P008', 'W004', 183),
('INV009', 'P009', 'W005', 132),
('INV010', 'P010', 'W001', 85),
('INV011', 'P011', 'W002', 197),
('INV012', 'P012', 'W003', 92),
('INV013', 'P013', 'W004', 66),
('INV014', 'P014', 'W005', 199),
('INV015', 'P015', 'W001', 181),
('INV016', 'P016', 'W002', 98),
('INV017', 'P017', 'W003', 165),
('INV018', 'P018', 'W004', 113),
('INV019', 'P019', 'W005', 89),
('INV020', 'P020', 'W001', 148);
SELECT * FROM INVENTORY;

INSERT INTO Payment (PaymentID, OrderID, PaymentDate, PaymentMethod, Amount) VALUES
('PAY001', 'O001', '2025-01-02', 'Credit Card', 2471.64),
('PAY002', 'O002', '2025-01-03', 'Cash on Delivery', 4669.59),
('PAY003', 'O003', '2025-01-04', 'Credit Card', 3548.83),
('PAY004', 'O004', '2025-01-05', 'Cash on Delivery', 2206.28),
('PAY005', 'O005', '2025-01-06', 'Net Banking', 1814.61),
('PAY006', 'O006', '2025-01-07', 'Credit Card', 3721.0),
('PAY007', 'O007', '2025-01-08', 'Debit Card', 3192.54),
('PAY008', 'O008', '2025-01-09', 'Credit Card', 2939.9),
('PAY009', 'O009', '2025-01-10', 'Debit Card', 1435.36),
('PAY010', 'O010', '2025-01-11', 'UPI', 4884.18),
('PAY011', 'O011', '2025-01-12', 'Cash on Delivery', 2750.44),
('PAY012', 'O012', '2025-01-13', 'Net Banking', 1286.55),
('PAY013', 'O013', '2025-01-14', 'Debit Card', 4481.26),
('PAY014', 'O014', '2025-01-15', 'Credit Card', 683.02),
('PAY015', 'O015', '2025-01-16', 'UPI', 1191.9),
('PAY016', 'O016', '2025-01-17', 'Net Banking', 4135.23),
('PAY017', 'O017', '2025-01-18', 'Debit Card', 1921.31),
('PAY018', 'O018', '2025-01-19', 'Net Banking', 1613.0),
('PAY019', 'O019', '2025-01-20', 'Credit Card', 1252.52),
('PAY020', 'O020', '2025-01-21', 'Net Banking', 2180.53);
SELECT * FROM PAYMENT;

INSERT INTO Shipping (ShippingID, OrderID, ShipDate, Carrier, TrackingNumber) VALUES
('SHP001', 'O001', '2025-01-03', 'Blue Dart', 'TN0000001'),
('SHP002', 'O002', '2025-01-04', 'Blue Dart', 'TN0000002'),
('SHP003', 'O003', '2025-01-05', 'DHL', 'TN0000003'),
('SHP004', 'O004', '2025-01-06', 'DHL', 'TN0000004'),
('SHP005', 'O005', '2025-01-07', 'Blue Dart', 'TN0000005'),
('SHP006', 'O006', '2025-01-08', 'FedEx', 'TN0000006'),
('SHP007', 'O007', '2025-01-09', 'FedEx', 'TN0000007'),
('SHP008', 'O008', '2025-01-10', 'Blue Dart', 'TN0000008'),
('SHP009', 'O009', '2025-01-11', 'FedEx', 'TN0000009'),
('SHP010', 'O010', '2025-01-12', 'DHL', 'TN0000010'),
('SHP011', 'O011', '2025-01-13', 'Blue Dart', 'TN0000011'),
('SHP012', 'O012', '2025-01-14', 'India Post', 'TN0000012'),
('SHP013', 'O013', '2025-01-15', 'India Post', 'TN0000013'),
('SHP014', 'O014', '2025-01-16', 'DTDC', 'TN0000014'),
('SHP015', 'O015', '2025-01-17', 'Blue Dart', 'TN0000015'),
('SHP016', 'O016', '2025-01-18', 'Blue Dart', 'TN0000016'),
('SHP017', 'O017', '2025-01-19', 'DHL', 'TN0000017'),
('SHP018', 'O018', '2025-01-20', 'India Post', 'TN0000018'),
('SHP019', 'O019', '2025-01-21', 'DHL', 'TN0000019'),
('SHP020', 'O020', '2025-01-22', 'DHL', 'TN0000020');
SELECT * FROM SHIPPING;

INSERT INTO Review (ReviewID, CustomerID, ProductID, Rating, Comment) VALUES
('R001', 'CUST001', 'P001', 5, 'Excellent product! Highly recommend.'),
('R002', 'CUST002', 'P002', 2, 'Not satisfied, expected better quality.'),
('R003', 'CUST003', 'P003', 3, 'Decent product, but could be better.'),
('R004', 'CUST004', 'P004', 5, 'Excellent product! Highly recommend.'),
('R005', 'CUST005', 'P005', 3, 'Decent product, but could be better.'),
('R006', 'CUST006', 'P006', 4, 'Great quality, worth the price.'),
('R007', 'CUST007', 'P007', 4, 'Great quality, worth the price.'),
('R008', 'CUST008', 'P008', 1, 'Poor product, would not recommend.'),
('R009', 'CUST009', 'P009', 2, 'Not satisfied, expected better quality.'),
('R010', 'CUST010', 'P010', 4, 'Great quality, worth the price.');
SELECT * FROM REVIEW;

-- Review Queries
-- Retrieve a list of all products along with their category names.
SELECT p.ProductID, p.Name AS ProductName, c.Name AS CategoryName
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID;

-- List all orders where a coupon was applied, along with the coupon code and discount value.
SELECT o.OrderID, c.Code, c.DiscountValue
FROM `Order` o
JOIN Coupon c ON o.CouponID = c.CouponID
WHERE o.CouponID IS NOT NULL;

-- Get the most recent 10 customer reviews with product names and ratings.
SELECT p.Name AS ProductName, r.Rating, r.Comment
FROM Review r
JOIN Product p ON r.ProductID = p.ProductID
ORDER BY r.ReviewID DESC
LIMIT 10;

-- Find the top 5 products based on the total quantity sold.
SELECT p.Name, SUM(oi.Quantity) AS TotalSold
FROM OrderItem oi
JOIN Product p ON oi.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalSold DESC
LIMIT 5;

-- Calculate the total spending of each customer.
SELECT c.FirstName, c.LastName, ROUND(SUM(p.Amount),2) AS TotalSpent
FROM Customer c
JOIN `Order` o ON c.CustomerID = o.CustomerID
JOIN Payment p ON o.OrderID = p.OrderID
GROUP BY c.CustomerID;

-- Calculate the average rating for each product.
SELECT p.Name, AVG(r.Rating) AS AverageRating
FROM Product p
JOIN Review r ON p.ProductID = r.ProductID
GROUP BY p.Name;

-- Calculate the total revenue generated through each payment method.
SELECT PaymentMethod, ROUND(SUM(Amount),2) AS TotalRevenue
FROM Payment
GROUP BY PaymentMethod;

-- Count the number of orders shipped by each carrier.
SELECT Carrier, COUNT(*) AS TotalOrders
FROM Shipping
GROUP BY Carrier;

-- Find products where the total stock across warehouses is less than 100.
SELECT p.Name, SUM(i.Quantity) AS TotalStock
FROM Product p
JOIN Inventory i ON p.ProductID = i.ProductID
GROUP BY p.Name
HAVING TotalStock < 100;

-- Find the customer who placed the maximum number of orders.
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customer c
JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalOrders DESC
LIMIT 1;

-- Calculate the average payment amount for all completed orders.
SELECT ROUND(AVG(p.Amount),2) AS AverageOrderValue
FROM Payment p
JOIN `Order` o ON p.OrderID = o.OrderID
WHERE o.Status = 'Delivered';

-- Calculate the average number of days taken to deliver by each carrier.
SELECT Carrier, AVG(DATEDIFF(ShipDate, OrderDate)) AS AvgDeliveryTime
FROM Shipping s
JOIN `Order` o ON s.OrderID = o.OrderID
GROUP BY Carrier;

-- Increase the price of all products in the "Electronics" category by 10%.
UPDATE Product p
JOIN Category c ON p.CategoryID = c.CategoryID
SET p.Price = p.Price * 1.10
WHERE c.Name = 'Electronics';
SELECT * FROM PRODUCT;

-- Correct the phone number of a customer whose email is "vihaan@mail.com".
UPDATE Customer
SET Phone = '9876543210'
WHERE Email = 'vihaan@mail.com';
SELECT * FROM customer;

-- Extend the expiry date of a discount named "Summer Sale" by 30 days.
UPDATE Discount
SET ExpiryDate = ExpiryDate + INTERVAL 30 DAY
WHERE Name = 'Summer Sale';
SELECT * FROM DISCOUNT;

-- Delete all reviews with a rating of 1.
DELETE FROM Review
WHERE Rating = 1;
SELECT * FROM REVIEW;

-- Remove all completed orders that are older than 70 DAYS.
-- Delete from the child table (OrderItem) first
DELETE oi
FROM OrderItem oi
JOIN `Order` o ON oi.OrderID = o.OrderID
WHERE o.Status = 'Delivered' 
  AND o.OrderDate < CURDATE() - INTERVAL 70 DAY;

-- Delete from the Payment table
DELETE p
FROM Payment p
JOIN `Order` o ON p.OrderID = o.OrderID
WHERE o.Status = 'Delivered' 
  AND o.OrderDate < CURDATE() - INTERVAL 70 DAY;

-- Delete from the Shipping table
DELETE s
FROM Shipping s
JOIN `Order` o ON s.OrderID = o.OrderID
WHERE o.Status = 'Delivered' 
  AND o.OrderDate < CURDATE() - INTERVAL 70 DAY;

-- Finally, delete from the Order table
DELETE FROM `Order`
WHERE Status = 'Delivered' 
  AND OrderDate < CURDATE() - INTERVAL 70 DAY;
SELECT * FROM `ORDER`;

-- Normal Testing
-- Check for non-atomic data (columns that may contain multiple values)
SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecommerce'
  AND (COLUMN_TYPE LIKE 'SET%' OR COLUMN_TYPE LIKE 'ENUM%');
  
-- Check for duplicate rows in each table

SELECT 'Warehouse' AS TableName, COUNT(*) AS Total_Rows, COUNT(DISTINCT CONCAT_WS(',', WarehouseID, Location)) AS Unique_Rows
FROM Warehouse
UNION ALL
SELECT 'Category', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', CategoryID, Name))
FROM Category
UNION ALL
SELECT 'Product', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', ProductID, Name, Description, Price, Stock, CategoryID))
FROM Product
UNION ALL
SELECT 'Inventory', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', InventoryID, ProductID, WarehouseID, Quantity))
FROM Inventory
UNION ALL
SELECT 'Customer', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', CustomerID, FirstName, LastName, Email, Phone))
FROM Customer
UNION ALL
SELECT 'Address', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', AddressID, CustomerID, Street, City, State, Country, ZipCode))
FROM Address
UNION ALL
SELECT 'Coupon', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', CouponID, Code, DiscountValue, ExpiryDate))
FROM Coupon
UNION ALL
SELECT 'Discount', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', DiscountID, Name, DiscountPercentage, ExpiryDate))
FROM Discount
UNION ALL
SELECT 'Order', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', OrderID, CustomerID, OrderDate, Status, DiscountID, CouponID))
FROM `Order`
UNION ALL
SELECT 'OrderItem', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', OrderItemID, OrderID, ProductID, Quantity))
FROM OrderItem
UNION ALL
SELECT 'Payment', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', PaymentID, OrderID, Amount, PaymentDate, PaymentMethod))
FROM Payment
UNION ALL
SELECT 'Shipping', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', ShippingID, OrderID, Carrier, ShipDate, TrackingNumber))
FROM Shipping
UNION ALL
SELECT 'Review', COUNT(*), COUNT(DISTINCT CONCAT_WS(',', ReviewID, ProductID, Rating, Comment, CustomerID))
FROM Review;

-- Check for inconsistent data types in each table
SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecommerce'
  AND DATA_TYPE NOT IN ('varchar', 'int', 'float', 'text', 'date');

