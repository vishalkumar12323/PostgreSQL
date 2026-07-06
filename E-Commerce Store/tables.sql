-- Active: 1783355267996@@127.0.0.1@5432@ecommerce
-- customers table.
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    city VARCHAR(50),
    signup_date DATE
);


SELECT * FROM public.customers;
-- insert data
INSERT INTO customers (first_name, last_name, email, city, signup_date)
VALUES
('Amit','Sharma','amit@gmail.com','Delhi','2023-01-15'),
('Priya','Verma','priya@gmail.com','Mumbai','2023-02-20'),
('Rahul','Singh','rahul@gmail.com','Jaipur','2023-03-05'),
('Sneha','Patel','sneha@gmail.com','Ahmedabad','2023-04-12'),
('Karan','Gupta','karan@gmail.com','Delhi','2023-05-18'),
('Neha','Yadav','neha@gmail.com','Lucknow','2023-06-22'),
('Rohit','Mehta','rohit@gmail.com','Pune','2023-07-10'),
('Anjali','Joshi','anjali@gmail.com','Mumbai','2023-08-02'),
('Vikas','Kapoor','vikas@gmail.com','Delhi','2023-09-15'),
('Pooja','Malik','pooja@gmail.com','Chandigarh','2023-10-08'),
('Deepak','Arora','deepak@gmail.com','Jaipur','2023-11-01'),
('Meena','Saini','meena@gmail.com','Delhi','2023-12-12');


-- categories table.
CREATE TABLE IF NOT EXISTS categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO categories (category_name)
VALUES 
    ('Electronics'),
    ('Clothing'),
    ('Books'),
    ('Home'),
    ('Sports');


-- products table.
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT REFERENCES categories(category_id),
    price DECIMAL(10, 2),
    stock INT
);

INSERT INTO products(product_name,category_id,price,stock)
VALUES
('Laptop',1,65000,15),
('Smartphone',1,30000,30),
('Headphones',1,2500,50),
('T-Shirt',2,800,100),
('Jeans',2,1800,70),
('Novel',3,450,120),
('Cookbook',3,600,40),
('Mixer Grinder',4,3500,20),
('Sofa',4,25000,5),
('Football',5,900,35),
('Cricket Bat',5,2200,25),
('Monitor',1,15000,18);


-- orders table.
CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    order_status VARCHAR(20)
);


INSERT INTO
    orders (
        customer_id,
        order_date,
        order_status
    )
VALUES (1, '2024-01-05', 'Delivered'),
    (2, '2024-01-08', 'Delivered'),
    (3, '2024-01-12', 'Cancelled'),
    (4, '2024-01-15', 'Delivered'),
    (5, '2024-01-20', 'Pending'),
    (1, '2024-02-01', 'Delivered'),
    (6, '2024-02-05', 'Delivered'),
    (7, '2024-02-10', 'Pending'),
    (8, '2024-02-15', 'Delivered'),
    (9, '2024-02-18', 'Delivered'),
    (10, '2024-02-25', 'Cancelled'),
    (11, '2024-03-01', 'Delivered'),
    (12, '2024-03-05', 'Pending'),
    (2, '2024-03-08', 'Delivered'),
    (5, '2024-03-10', 'Delivered');


-- order_items table.
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT
);

INSERT INTO
    order_items (
        order_id,
        product_id,
        quantity
    )
VALUES (1, 1, 1),
    (1, 3, 2),
    (2, 4, 3),
    (2, 6, 2),
    (3, 2, 1),
    (4, 9, 1),
    (5, 11, 1),
    (6, 12, 2),
    (7, 8, 1),
    (8, 10, 2),
    (9, 5, 2),
    (10, 7, 1),
    (11, 1, 1),
    (12, 2, 2),
    (13, 4, 4),
    (14, 11, 2),
    (15, 3, 3);


-- payments table.
CREATE TABLE IF NOT EXISTS payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    payment_method VARCHAR(30),
    amount DECIMAL(10, 2),
    payment_status VARCHAR(20)
);


INSERT INTO
    payments (
        order_id,
        payment_method,
        amount,
        payment_status
    )
VALUES (1, 'UPI', 70000, 'Paid'),
    (2, 'Card', 3300, 'Paid'),
    (3, 'UPI', 30000, 'Refunded'),
    (
        4,
        'Net Banking',
        25000,
        'Paid'
    ),
    (5, 'COD', 2200, 'Pending'),
    (6, 'Card', 30000, 'Paid'),
    (7, 'UPI', 3500, 'Paid'),
    (8, 'Card', 1800, 'Pending'),
    (9, 'UPI', 3600, 'Paid'),
    (10, 'COD', 600, 'Refunded'),
    (11, 'Card', 65000, 'Paid'),
    (12, 'UPI', 60000, 'Pending'),
    (13, 'Card', 3200, 'Pending'),
    (
        14,
        'Net Banking',
        4400,
        'Paid'
    ),
    (15, 'UPI', 7500, 'Paid');