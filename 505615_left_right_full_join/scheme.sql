--1) вывести всех пользователей и количество их заказов, включая пользователей без заказов.
-- Требования к результату:
-- user_id
-- user_name
-- количество заказов
SELECT u.id as user_id,
       u.name as user_name,
        COUNT(o.id)
FROM idea_db."505601".users u
LEFT JOIN idea_db."505601".orders o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY u.id;

--2) найти заказы, по которым еще не было платежа.
-- В результате вывести:
-- order_id
-- статус заказа
-- время создания заказа
SELECT o.id as order_id,
       o.status,
       o.created_at
FROM idea_db."505601".orders o
LEFT JOIN idea_db."505601".payments p on o.id = p.order_id
WHERE p.id IS NULL;


--3) вывести товары, которые встречались хотя бы в одном заказе, и рядом показать, сколько раз они встречались в order_items.
SELECT p.id as product_id,
       p.name,
       COUNT(oi.id)
FROM idea_db."505601".order_items oi
JOIN idea_db."505601".products p on p.id = oi.product_id
GROUP BY p.id, p.name;


--4) вывести все роли и количество пользователей, которым назначена каждая роль
SELECT r.code, r.name, COUNT(ur.user_id)
FROM idea_db."505601".roles r
LEFT JOIN idea_db."505601".user_roles ur ON r.id = ur.role_id
GROUP BY r.code, r.name
ORDER BY r.code;

--5) найти пользователей, которым не назначена ни одна роль.
SELECT u.id, u.name
FROM idea_db."505601".users u
LEFT JOIN idea_db."505601".user_roles ur ON u.id = ur.user_id
WHERE ur.user_id IS NULL;

--6) сделать сверочный запрос по ролям и назначениям ролей так, чтобы в результате были видны:
-- роли, назначенные пользователям;
-- роли без пользователей;
-- все пары role ↔ user, которые существуют.
SELECT
    r.code,
    ur.user_id
FROM idea_db."505601".roles AS r
FULL JOIN idea_db."505601".user_roles AS ur ON ur.role_id = r.id;

--7) построить все комбинации “роль × окружение”.
SELECT
    r.code AS role_code,
    e.code AS environment_code
FROM idea_db."505601".roles AS r
CROSS JOIN idea_db."505601".environments AS e;

--8) вывести все категории вместе с именем их родительской категории.
SELECT
    c.id,
    c.name AS category_name,
    p.name AS parent_category_name
FROM idea_db."505601".categories AS c
LEFT JOIN idea_db."505601".categories AS p ON c.parent_id = p.id;
