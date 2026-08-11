--вывести статусы заказов, по которым количество заказов не меньше 3.
SELECT status,
       COUNT(*) AS orders_count
FROM idea_db."505601".orders
GROUP BY status
HAVING COUNT(*) >= 3;

--для каждого пользователя вывести суммарную стоимость всех его заказов, но оставить только тех пользователей, у которых общая сумма заказов больше 10000.
SELECT u.id,
       u.name,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM idea_db."505601".users u
JOIN idea_db."505601".orders o on u.id = o.user_id
JOIN idea_db."505601".order_items oi on o.id = oi.order_id
GROUP BY u.id, u.name
HAVING SUM(oi.quantity * oi.unit_price) > 10000;

--вывести товары, по которым суммарно продано от 5 единиц и больше, но учитывать только те строки заказа, где unit_price >= 1000.
SELECT p.id AS product_id,
       p.name AS product_name,
       SUM(oi.quantity) AS total_quantity
FROM idea_db."505601".products p
JOIN idea_db."505601".order_items oi on p.id = oi.product_id
WHERE oi.unit_price >= 1000
GROUP BY p.id, p.name
HAVING SUM(oi.quantity) >= 5;


--для каждого пользователя и каждого статуса заказа вывести количество заказов, но оставить только те группы, где количество заказов больше 1.
SELECT u.id as user_id,
       u.name as user_name,
       o.status,
       COUNT(o.id) AS orders_count
FROM idea_db."505601".users u
JOIN idea_db."505601".orders o on u.id = o.user_id
GROUP BY u.id, u.name, o.status
HAVING COUNT(o.id) > 1;


--вывести заказы, в которых суммарно куплено не меньше 4 единиц товара.
SELECT o.id AS order_id,
       SUM(oi.quantity) AS total_quantity
FROM idea_db."505601".orders o
JOIN idea_db."505601".order_items oi on o.id = oi.order_id
GROUP BY o.id
HAVING SUM(oi.quantity) >= 4;

--вывести пользователей, у которых есть хотя бы 2 заказа со статусом PAID.
SELECT u.id as user_id,
       u.name as user_name,
        COUNT(o.id) as paid_orders_count
FROM idea_db."505601".users u
JOIN idea_db."505601".orders o on u.id = o.user_id
WHERE o.status = 'PAID'
GROUP BY u.id, u.name
HAVING COUNT(o.id) >= 2;

--для каждого товара вывести минимальную и максимальную цену продажи из order_items, но оставить только те товары, у которых максимальная цена продажи больше 5000.
SELECT p.id AS product_id,
       p.name AS product_name,
        MIN(oi.unit_price) AS min_unit_price,
        MAX(oi.unit_price) AS max_unit_price
FROM idea_db."505601".products p
JOIN idea_db."505601".order_items oi on p.id = oi.product_id
GROUP BY p.id, p.name
HAVING MAX(oi.unit_price) > 5000;

--вывести статусы заказов, для которых средняя сумма строки заказа больше 2000, но учитывать только заказы, созданные начиная с 1 января 2025 года.
SELECT o.status,
       SUM(oi.unit_price * oi.quantity) AS avg_line_total
FROM idea_db."505601".orders o
JOIN idea_db."505601".order_items oi on o.id = oi.order_id
WHERE o.created_at >= '2025-01-01'
GROUP BY o.status
HAVING SUM(oi.unit_price) > 2000;