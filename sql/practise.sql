sqlite3 practice.db
'''
    Mainly working through the problems on SQLZoo
'''
    
CREATE TABLE sales (
    id INTEGER PRIMARY KEY,
    name TEXT,
    amount INTEGER,
    category TEXT
);

INSERT INTO sales (name, amount, category)
VALUES
    ('Alice', 200, 'A'),
    ('Bob', 150, 'B'),
    ('Alice', 100, 'A'),
    ('Chris', 250, 'B');


SELECT category, AVG(amount) AS avg_sales
FROM sales
GROUP BY category
ORDER BY avg_sales DESC;

customers(id, name, region)
orders(order_id, customer_id, amount, order_date)
plans(customer_id, plan_type, start_date)
products(product_id, category, price)
order_items(order_id, product_id, quantity)

SELECT amount
    SUM(amount) AS Total_revenue
    AVG(amount) AS Avg_order_value
FROM orders;

SELECT customer_id, COUNT(*), AS orders_2025
FROM orders
WHERE order_date >= '2025-01-01' AND order_date < '2026-01-01'
GROUP BY customer_id
    HAVING COUNT(*) > 3;

SELECT c.name, SUM(o.amount) AS total_spent 
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_spent, DESC;

SELECT c.region, COUNT(DISTINCT c.id) AS unique_customers
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY region
ORDER BY unique_customers DESC;

SELECT 
    c.id,
    c.name,
    COALESCE(SUM(o.amount), 0) AS total_spend_2025
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
    AND EXTRACT(YEAR FROM o.order_date) = 2025
GROUP BY c.id, c.name
ORDER BY total_spend_2025 DESC;






SELECT c.id, c.name, c.region
FROM customers c
WHERE region = 'North'
ORDER BY c.name;

SELECT 
    c.region, 
    COUNT(DISTINCT c.id) AS num_customers
FROM customers c
GROUP BY 
    c.region
HAVING 
    COUNT(DISTINCT c.id) > 2
ORDER BY 
    num_customers DESC;

SELECT 
    c.id,
    c.name,
    COALESCE(SUM(o.amount),0) AS total_spent
FROM customers c
LEFT JOIN orders o 
    ON o.customer_id = c.id
GROUP BY c.name, c.id
ORDER BY 
    total_spent DESC;


SELECT 
    c.region,
    COUNT(DISTINCT c.id) AS unique_customers,
    COALESCE(SUM(o.amount), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.id
    WHERE o.order_date >= '2025-01-01' 
    AND o.order_date < '2026-01-01'
GROUP BY c.region 
ORDER BY total_revenue DESC;

orders
| order_id | customer_id | order_date |

order_items
| order_id | product_id | quantity |

products
| product_id | category | price |

SELECT 
    p.category,
    COALESCE(PRODUCT(oi.quantity, p.price)) AS Total_value
FROM order_items oi

JOIN orders o
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id

GROUP BY p.category;


SELECT
category,
total_revenue,
rank 
FROM (
    SELECT
        p.category,
        SUM(oi.quantity * p.price) AS total_revenue,
        RANK() OVER (ORDER BY
      SUM(oi.quantity* p.price) DESC) AS rank

    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id

    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_date >= '2025-01-01'
    AND o.order_date < '2026-01-01'
    GROUP BY p.category
    ) AS ranked
WHERE rank <= 3
ORDER BY rank ASC;


SELECT name
FROM actor JOIN casting ON id = actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(ord) >= 15

SELECT DISTINCT name
FROM actor JOIN movie ON id
WHERE director = 'Art Garfunkel'

SELECT c.name, SUM(amount) AS total_spent,
MAX(order_date) AS last_order_date
FROM Customers c JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY SUM(amount) DESC;


SELECT c.name, SUM(o.amount) AS total_spend
FROM Customers c JOIN Orders o 
ON c.customer_id = o.customer_id
GROUP By c.customer_id, c.name
HAVING SUM(o.amount) > 
(
SELECT SUM(amount) / COUNT(DISTINCT customer_id)
FROM Orders
)
ORDER BY total_spend DESC

SELECT c.name, SUM(o.amount) AS total_amount_spent
FROM Customers c JOIN Orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name

SELECT c.name, c.customer_id
FROM Customers c
JOIN (
  SELECT o.customer_id, SUM(o.amount) AS total
FROM Orders o
GROUP BY o.customer_id  
) AS totals
ON totals.customer_id = c.customer_id
ORDER BY totals.total DESC
LIMIT 1 OFFSET 1;



SELECT p1.product
FROM price_updates p1
WHERE NOT EXISTS (
    SELECT 1 
    FROM price_updates p2
    WHERE p2.product = p1.product
        AND p2.date > p1.date
        AND p2.price <= p1.price 
)
GROUP BY p1.product
HAVING COUNT(*) > 1;
