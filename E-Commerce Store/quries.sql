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