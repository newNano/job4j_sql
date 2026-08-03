--выполните выборку всех пользователей, выводите все поля которые есть в таблице;
SELECT * FROM idea_db."505601".users;

--выполните выборку всей пользователей, выведите только поля name и email;
SELECT name, email FROM idea_db."505601".users;

--выполните выборку всех пользователей, выводите значения полей id, name, email и для этих полей используйте алиасы user_id, user_name, user_email;
SELECT id AS user_id,
       name AS user_name,
       email AS user_email
FROM idea_db."505601".users;

--выполните выборку всех заказов, для каждой строки заказа посчитайте стоимость. Выводите значение полей id строки заказа, order_id, product_id, quantity, unit_price и стоимость строки заказа с алиасом line_total;
SELECT id,
       order_id,
       product_id,
       quantity,
       unit_price,
       quantity * unit_price AS line_total
FROM idea_db."505601".order_items;

-- покажите цену товара со скидкой 10%, выводите id, name, price и цену с учетом скидки в поле с алиасом discounted_price
SELECT id,
       name,
       price,
       price * 0.9 AS discounted_price
FROM idea_db."505601".products;
