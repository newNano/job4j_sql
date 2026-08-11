--для каждого статуса заказа вывести количество заказов.
SELECT status,
       COUNT(*) AS orders_count
FROM idea_db."505601".orders
GROUP BY status;

--для каждого пользователя вывести общую сумму всех его заказов
SELECT u.id,
       u.name,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM idea_db."505601".users u
JOIN idea_db."505601".orders o on u.id = o.user_id
JOIN idea_db."505601".order_items oi on o.id = oi.order_id
GROUP BY u.id, u.name;

--для каждого товара вывести:
-- сколько раз этот товар встретился в строках заказа;
-- сколько единиц товара было продано суммарно.
SELECT p.id AS product_id,
       p.name AS product_name,
       COUNT(oi.product_id) AS order_items_count,
       COALESCE(SUM(oi.quantity), 0) AS total_quantity
FROM idea_db."505601".products p
LEFT JOIN idea_db."505601".order_items oi on p.id = oi.product_id
GROUP BY p.id, p.name;


--для каждого заказа вывести:
-- order_id
-- количество строк в заказе;
-- итоговую сумму заказа.
SELECT oi.order_id,
        COUNT(oi.order_id) AS items_count,
        SUM(oi.quantity * oi.unit_price) AS order_total
FROM idea_db."505601".order_items oi
GROUP BY oi.order_id;

-- для каждого пользователя и для каждого статуса его заказов вывести количество таких заказов.
SELECT u.id as user_id,
       u.name as user_name,
       o.status,
       COUNT(o.id) AS orders_count
FROM idea_db."505601".users u
JOIN idea_db."505601".orders o on u.id = o.user_id
GROUP BY u.id, u.name, o.status;


--вывести минимальную, максимальную и среднюю цену продажи по каждому товару на основании order_items.
SELECT p.id as product_id,
       p.name as product_name,
       MIN(oi.unit_price) as min_unit_price,
       MAX(oi.unit_price) as max_unit_price,
       AVG(oi.unit_price) as avg_unit_price
FROM idea_db."505601".products p
JOIN idea_db."505601".order_items oi ON oi.product_id = p.id
GROUP BY p.id, p.name;

--вывести пользователей и количество их заказов, включая пользователей, у которых заказов нет.
SELECT u.id as user_id,
       u.name as user_name,
       COUNT(o.id) AS orders_count
FROM idea_db."505601".users u
LEFT JOIN idea_db."505601".orders o on u.id = o.user_id
GROUP BY u.id, u.name;