-- -- Создание таблиц
-- CREATE TABLE idea_db."505621".products (
--     product_id SERIAL PRIMARY KEY,
--     product_name VARCHAR(100) NOT NULL,
--     category VARCHAR(50) NOT NULL,
--     price NUMERIC(10, 2) NOT NULL
-- );
--
-- CREATE TABLE idea_db."505621".orders (
--     order_id SERIAL PRIMARY KEY,
--     customer_name VARCHAR(100),
--     order_date DATE NOT NULL,
--     status VARCHAR(20) NOT NULL -- 'completed', 'cancelled'
-- );
--
-- CREATE TABLE idea_db."505621".order_items (
--     item_id SERIAL PRIMARY KEY,
--     order_id INT REFERENCES idea_db."505621".orders(order_id),
--     product_id INT REFERENCES idea_db."505621".products(product_id),
--     quantity INT NOT NULL
-- );
--
-- -- Заполнение тестовыми данными
-- INSERT INTO idea_db."505621".products (product_name, category, price) VALUES
--                                                          ('Ноутбук Apple MacBook Air', 'Электроника', 90000.00),
--                                                          ('Мышь Logitech MX Master', 'Аксессуары', 8000.00),
--                                                          ('Клавиатура Keychron K2', 'Аксессуары', 7500.00),
--                                                          ('Наушники Sony WH-1000XM5', 'Аудио', 25000.00);
--
-- INSERT INTO idea_db."505621".orders (customer_name, order_date, status) VALUES
--                                                            ('Иван Иванов', '2023-10-01', 'completed'),
--                                                            ('Петр Петров', '2023-10-02', 'completed'),
--                                                            ('Анна Смирнова', '2023-10-03', 'completed'),
--                                                            ('Елена Попова', '2023-10-04', 'cancelled'), -- Отмененный заказ!
--                                                            ('Иван Иванов', '2023-10-05', 'completed');
--
-- -- Состав заказов
-- -- Заказ 1: 1 Ноутбук + 1 Мышь
-- INSERT INTO idea_db."505621".order_items (order_id, product_id, quantity) VALUES
--                                                              (1, 1, 1), (1, 2, 1);
-- -- Заказ 2: 2 Клавиатуры
-- INSERT INTO idea_db."505621".order_items (order_id, product_id, quantity) VALUES
--     (2, 3, 2);
-- -- Заказ 3: 1 Наушники + 1 Мышь
-- INSERT INTO idea_db."505621".order_items (order_id, product_id, quantity) VALUES
--                                                              (3, 4, 1), (3, 2, 1);
-- -- Заказ 4 (Отменен): 1 Ноутбук
-- INSERT INTO idea_db."505621".order_items (order_id, product_id, quantity) VALUES
--     (4, 1, 1);
-- -- Заказ 5: 1 Мышь + 1 Клавиатура
-- INSERT INTO idea_db."505621".order_items (order_id, product_id, quantity) VALUES
--                                                              (5, 2, 1), (5, 3, 1);

--Задача 1. Лучшие клиенты (TOP) Выведите имена клиентов и суммарную выручку, которую они принесли.
-- Учтите только успешные заказы. Отсортируйте результат по убыванию выручки и оставьте только двух самых прибыльных клиентов.
SELECT o.customer_name,
        SUM(oi.quantity * p.price) AS total_revenue
FROM idea_db."505621".orders o
JOIN idea_db."505621".order_items oi ON o.order_id = oi.order_id
JOIN idea_db."505621".products p ON oi.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY o.customer_name
ORDER BY total_revenue DESC
LIMIT 2;

--Задача 2. Фильтрация категорий (HAVING) Посчитайте общее количество проданных товаров и суммарную выручку для каждой категории (только успешные заказы).
-- Выведите только те категории, суммарная выручка которых превышает 30 000 рублей.
SELECT p.category,
       COUNT(oi.quantity) as total_items_sold,
       SUM(oi.quantity * p.price) AS category_revenue
FROM idea_db."505621".orders o
JOIN idea_db."505621".order_items oi ON o.order_id = oi.order_id
JOIN idea_db."505621".products p ON oi.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY p.category
HAVING SUM(oi.quantity * p.price) > 30000;

-- Задача 3. Ловушка среднего (CTE + AVG) Руководство попросило посчитать:
-- «какое среднее количество товарных позиций (штук) находится в одном успешном заказе?»
WITH OrderTotals as (
    SELECT o.order_id,
    COUNT(oi.product_id) AS total_items_sold
    FROM idea_db."505621".orders o
    JOIN idea_db."505621".order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id
)
SELECT ROUND(AVG(total_items_sold)) FROM OrderTotals;
