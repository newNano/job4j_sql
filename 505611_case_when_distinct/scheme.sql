--1) Вывести товары и добавить колонку price_label:
-- если цена меньше 5000 - 'cheap'
-- если от 5000 до 50000 -'regular'
-- иначе 'premium'
SELECT id,
       name,
       price,
        CASE
            WHEN price < 5000 THEN 'cheap'
            WHEN price BETWEEN 5000 AND 50000 THEN 'regular'
            ELSE 'premium'
        END AS price_label
FROM idea_db."505601".products;


--2)Вывести пользователей и колонку phone_status:
-- если телефон NULL - 'not specified'
-- иначе specified
-- В результатах отражаем колонки: id, name, phone, phone_status;
SELECT id,
       name,
       phone,
       CASE
           WHEN phone IS NULL THEN 'not specified'
           ELSE 'specified'
       END AS phone_status
FROM idea_db."505601".users;

--3)Получить список уникальных статусов заказов. В результатах отражаем колонки: status
SELECT DISTINCT status
FROM idea_db."505601".orders;

--4)Получить список уникальных пользователей, которые оформляли заказы. В результатах отражаем колонки: user_id.
SELECT DISTINCT user_id
FROM idea_db."505601".orders;

--5)Получить по одному самому новому заказу для каждого пользователя. В результатах отражаем колонки: id, user_id, status, created_at.
SELECT DISTINCT ON (user_id)
    id,
    user_id,
    status,
    created_at
FROM idea_db."505601".orders
ORDER BY user_id, created_at DESC, id DESC;

--6)Получить по одному самому дорогому товару для каждого имени товара, если в таблице встречаются несколько строк с одинаковым name. В результатах отражаем колонки: id, name, price.
SELECT DISTINCT ON (name)
    id,
    name,
    price
FROM idea_db."505601".products
ORDER BY name, price DESC, id DESC;
