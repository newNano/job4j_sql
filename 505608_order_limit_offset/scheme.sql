-- вывести все товары, отсортированные по имени по возрастанию. В результатах отражаем колонки: id, name, price:
SELECT id, name, price
FROM idea_db."505601".products
ORDER BY name;

--вывести 5 самых дешевых активных товаров. В результатах отражаем колонки: id, name, price:
SELECT id, name, price
FROM idea_db."505601".products
WHERE is_active = true
ORDER BY price, id
LIMIT 5;

--вывести 10 последних заказов. В результатах отражаем колонки: id, user_id, status, created_at;
SELECT id, user_id, status, created_at
FROM idea_db."505601".orders
ORDER BY created_at DESC, id DESC
LIMIT 10;

--показать вторую страницу пользователей, если на одной странице 20 строк. Сортировать по created_at DESC, id DESC. В результатах отражаем колонки: id, name, email;
SELECT id, name, email
FROM idea_db."505601".users
ORDER BY created_at DESC, id DESC
LIMIT 20 OFFSET 20;

--вывести все строки order_items, отсортированные:
-- по order_id,
-- внутри заказа - по unit_price по убыванию,
-- а при равной цене - по id.
SELECT *
FROM idea_db."505601".order_items
ORDER BY order_id ASC, unit_price DESC, id ASC;

--показать третью страницу товаров по 3 товара на странице, отсортированных по цене от дорогих к дешевым, а при равной цене - по id. В результатах отражаем колонки: id, name, price
SELECT id, name, price
FROM idea_db."505601".products
ORDER BY price, id
LIMIT 3 OFFSET 6;
