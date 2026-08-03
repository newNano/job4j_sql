--3
INSERT INTO idea_db."505601".users (name, email)
    VALUES ('Ivan Petrov', 'ivan.petrov@example.com')
RETURNING *;

--4
INSERT INTO idea_db."505601".users (name, email)
VALUES
    ('Anna Smirnova', 'anna.smirnova@example.com'),
    ('Petr Ivanov', 'petr.ivanov@example.com'),
    ('Olga Sidorova', 'olga.sidorova@example.com')
RETURNING id, name, email;


SELECT id, name, email, created_at
FROM idea_db."505601".users
ORDER BY id;

--5
INSERT INTO idea_db."505601".products (name, price, is_active)
VALUES
    ('iPhone 17', 99990.00, true),
    ('MacBook Air M5', 149990.00, true),
    ('AirPods Pro 2', 24990.00, true),
    ('Old Keyboard', 1500.00, false)
RETURNING id, name, price, is_active;

--6
INSERT INTO idea_db."505601".orders (user_id, status)
VALUES
    (1, 'NEW'),
    (2, 'PAID')
RETURNING id, user_id, status, created_at;

--7
INSERT INTO idea_db."505601".order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 99990.00),
    (1, 3, 2, 24990.00),
    (2, 2, 1, 149990.00)
RETURNING *;

--8
SELECT
    o.id AS order_id,
    u.name AS user_name,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS line_total,
    o.status,
    o.created_at
FROM idea_db."505601".orders o
         JOIN idea_db."505601".users u ON u.id = o.user_id
         JOIN idea_db."505601".order_items oi ON oi.order_id = o.id
         JOIN idea_db."505601".products p ON p.id = oi.product_id
ORDER BY o.id, oi.id;


--9
DROP TABLE IF EXISTS idea_db."505601".inactive_products_archive;

CREATE TABLE idea_db."505601".inactive_products_archive
(
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id   BIGINT         NOT NULL,
    product_name TEXT           NOT NULL,
    price        NUMERIC(12, 2) NOT NULL,
    archived_at  TIMESTAMPTZ    NOT NULL DEFAULT now()
);


--Перенос неактивных товаров, у которых is_active = false
INSERT INTO idea_db."505601".inactive_products_archive (product_id, product_name, price)
(SELECT id, name, price
FROM idea_db."505601".products
WHERE is_active = false)