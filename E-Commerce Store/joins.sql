-- Active: 1783355328541@@127.0.0.1@5432@ecommerce
-- Returns customers with their orders.
SELECT c.customer_id, c.first_name, c.last_name, c.email, c.city, o.order_id, o.order_date, o.order_status
FROM customers as c
    INNER JOIN orders as o ON c.customer_id = o.customer_id;

-- Returns customers who never ordered.
SELECT c.customer_id, c.first_name, c.last_name, c.email, c.city, o.order_id, o.order_date, o.order_status
FROM public.customers as c
    LEFT JOIN public.orders as o ON c.customer_id = o.customer_id
WHERE
    o.customer_id IS NULL;

-- Using NOT IN.
SELECT c.first_name AS Customers
FROM public.customers as c
WHERE
    c.customer_id NOT IN (
        SELECT o.customer_id
        FROM public.orders as o
    );

-- Using NOT EXISTS.
SELECT c.first_name AS Customers
FROM public.customers AS c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM public.orders AS o
        WHERE
            o.customer_id = c.customer_id
    );

SELECT c.customer_id, c.first_name, c.last_name, c.email, c.city, o.order_id, o.order_date, o.order_status
FROM public.orders AS o
    RIGHT JOIN public.customers AS c ON o.customer_id = c.customer_id
WHERE
    c.customer_id IS NULL;