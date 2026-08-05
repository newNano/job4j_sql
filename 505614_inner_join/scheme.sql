--1) вывести список заказов в виде:
-- order_id
-- статус заказа
-- email пользователя, который оформил заказ
-- Результат должен быть отсортирован по order_id.
SELECT o.id as order_id,
       o.status,
       u.email
FROM idea_db."505601".orders o
JOIN idea_db."505601".users u ON o.user_id = u.id
ORDER BY order_id;

--2)вывести все строки заказов, в которых количество товара больше 1, и показать:
-- order_item_id
-- order_id
-- название товара
-- количество
SELECT oi.id as order_item_id,
       o.id as order_id,
       p.name,
       oi.quantity
FROM idea_db."505601".orders o
JOIN idea_db."505601".order_items oi ON o.id = oi.order_id
JOIN idea_db."505601".products p on p.id = oi.product_id
WHERE oi.quantity > 1;

--3) показать все товары, которые встречаются в заказах пользователя с id = 1. В результате вывести:
-- order_id
-- название товара
-- количество
-- цену на момент покупки
SELECT o.id as order_id,
       p.name,
       oi.quantity,
       oi.unit_price
FROM idea_db."505601".orders o
JOIN idea_db."505601".order_items oi ON o.id = oi.order_id
JOIN idea_db."505601".products p on p.id = oi.product_id
WHERE user_id = 1;


--4) вывести все заказы со статусом NEW вместе с именем пользователя, который их оформил. В результате нужны:
-- order_id
-- status
-- user_name
SELECT o.id as order_id,
       o.status,
       u.name as user_name
FROM idea_db."505601".orders o
JOIN idea_db."505601".users u ON o.user_id = u.id
WHERE o.status = 'NEW';

--5) для каждой строки заказа вывести:
-- order_item_id
-- название товара
-- количество
-- line_total, то есть quantity * unit_price
SELECT oi.id as order_item_id,
       p.name,
       oi.quantity,
       oi.unit_price,
       oi.quantity * oi.unit_price as line_total
FROM idea_db."505601".orders o
JOIN idea_db."505601".order_items oi ON o.id = oi.order_id
JOIN idea_db."505601".products p on p.id = oi.product_id;

