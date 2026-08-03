--вывести все активные товары - нужно получить все товары, которые доступны к продаже
SELECT id,
       name,
       price,
       is_active
FROM idea_db."505601".products
WHERE is_active = true;

--вывести все товары в диапазоне цен от 10 000 до 100 000. В результатах отражаем колонки: id, name, price;
SELECT id,
       name,
       price
FROM idea_db."505601".products
WHERE price BETWEEN 10000 AND 100000;

--вывести все заказы со статусом NEW или PAID. В результатах отражаем колонки: id, user_id, status, created_at;
SELECT id,
       user_id,
       status,
       created_at
FROM idea_db."505601".orders
WHERE status IN ('NEW', 'PAID');

--вывести все заказы пользователя с user_id = 1, которые еще не отменены. Для этого запроса добавьте статус 'CANCELLED' и несколько заказов для пользователя с user_id = 1 с этим статусом. В результатах отражаем колонки: id, user_id, status, created_at;
SELECT id,
       user_id,
       status,
       created_at
FROM idea_db."505601".orders
WHERE status != 'CANCELLED';

--вывести пользователей, созданных в определенный период - за текущий год. В результатах отражаем колонки: id, name, email, created_at
SELECT id,
       name,
       email,
       created_at
FROM idea_db."505601".users
WHERE created_at BETWEEN '2026-01-01' AND '2027-01-01';


--вывести все товары, цена которых не входит в диапазон от 20 000 до 80 000. В результатах отражаем колонки: id, name, price;
SELECT id,
       name,
       price
FROM idea_db."505601".products
WHERE price NOT BETWEEN 20000 AND 80000;


--вывести все товары, которые активны и стоят либо меньше 3 000, либо больше 150 000. В результатах отражаем колонки: id, name, price.
SELECT id,
       name,
       price
FROM idea_db."505601".products
WHERE price < 3000 OR price > 150000;

