CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10,2)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2) 
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Tran Thi B', 'Hai Phong'),
(3, 'Le Van C', 'Da Nang'),
(4, 'Pham Thi D', 'Ha Noi'),
(5, 'Hoang Van E', 'Ho Chi Minh'),
(6, 'Do Thi F', 'Hai Phong');
;

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2024-01-10', 2500.00),
(102, 2, '2024-01-12', 1800.00),
(103, 3, '2024-01-15', 3200.00),
(104, 1, '2024-02-01', 1500.00),
(105, 4, '2024-02-05', 4000.00),
(106, 5, '2024-02-10', 5000.00),
(107, 6, '2024-02-15', 1200.00),
(108, 2, '2024-03-01', 2200.00),
(109, 5, '2024-03-05', 3500.00),
(110, 4, '2024-03-10', 2700.00);
;

INSERT INTO order_items (item_id, order_id, product_name, quantity, price) VALUES
(1, 101, 'Laptop', 1, 2500.00),
(2, 102, 'Phone', 2, 900.00),
(3, 103, 'Tablet', 2, 1600.00),
(4, 104, 'Mouse', 5, 300.00),
(5, 105, 'Monitor', 2, 2000.00),
(6, 106, 'Laptop', 2, 2500.00),
(7, 107, 'Keyboard', 4, 300.00),
(8, 108, 'Headphone', 2, 1100.00),
(9, 109, 'Phone', 3, 1166.67),
(10, 110, 'Tablet', 3, 900.00);

--1
SELECT
	c.customer_name AS customer_name,
	o.order_date AS order_date,
	o.total_amount AS total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

--2
SELECT 
	SUM(o.total_amount) AS total_revenue,
	AVG(o.total_amount) AS avg_order,
	MAX(o.total_amount) AS max_order,
	MIN(o.total_amount) AS min_order,
	COUNT(o.order_id) AS total_orders
FROM orders o;

--3
SELECT 
	c.city,
	SUM(o.total_amount) AS total_revenue,
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

--4
SELECT
	c.customer_name,
	o.order_date,
	oi.quantity,
	oi.price,
	oi.product_name
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id;

--5
SELECT 
	c.customer_name,
	SUM(o.total_amount) AS total_revenue
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (SELECT MAX(total_amount) FROM (SELECT SUM(total_amount) AS total_amount FROM orders GROUP BY customer_id) AS temp);