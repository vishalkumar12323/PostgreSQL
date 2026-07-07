-- Active: 1783355328541@@127.0.0.1@5432@ecommerce@public
-- Returns all customers from Delhi.
SELECT * FROM public.customers WHERE city = 'Delhi';

-- Returns all products in Ascending order
SELECT * FROM public.products ORDER BY price;

-- Returns top 5 expensive products.
SELECT product_name, price, stock
FROM public.products
ORDER BY price DESC
LIMIT 5;

-- Returns cheapest and expensive products.
SELECT
    MIN(price) as cheapest_item,
    MAX(price) as expensive_item
FROM public.products;

-- With product information Using subqueries.
SELECT product_name, price, stock
FROM public.products
WHERE
    price = (
        SELECT MIN(price)
        FROM public.products
    )
    OR price = (
        SELECT MAX(price)
        FROM public.products
    );

-- Returns the number of customers per city.
SELECT city, count(*) as customer_count
FROM customers
GROUP BY
    customers.city;

-- Returns the total payment amount.
SELECT SUM(amount) as total_amount FROM payments;