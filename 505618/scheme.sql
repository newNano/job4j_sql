-- DROP TABLE IF EXISTS idea_db."505618".cars;
-- DROP TABLE IF EXISTS idea_db."505618".car_bodies;
-- DROP TABLE IF EXISTS idea_db."505618".car_engines;
-- DROP TABLE IF EXISTS idea_db."505618".car_transmissions;
--
-- CREATE TABLE idea_db."505618".car_bodies (
--     id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     name TEXT NOT NULL UNIQUE
-- );
--
-- CREATE TABLE idea_db."505618".car_engines (
--     id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     name TEXT NOT NULL UNIQUE
-- );
--
-- CREATE TABLE idea_db."505618".car_transmissions (
--     id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     name TEXT NOT NULL UNIQUE
-- );
--
-- CREATE TABLE idea_db."505618".cars (
--     id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     name TEXT NOT NULL,
--     body_id BIGINT REFERENCES idea_db."505618".car_bodies(id),
--     engine_id BIGINT REFERENCES idea_db."505618".car_engines(id),
--     transmission_id BIGINT REFERENCES idea_db."505618".car_transmissions(id)
-- );
--
--
-- INSERT INTO idea_db."505618".car_bodies (name)
-- VALUES
--     ('sedan'),
--     ('hatchback'),
--     ('wagon'),
--     ('coupe'),
--     ('crossover'),
--     ('suv'),
--     ('pickup'),
--     ('minivan'),
--     ('roadster'),
--     ('liftback');
--
-- INSERT INTO idea_db."505618".car_engines (name)
-- VALUES
--     ('1.6 gasoline'),
--     ('2.0 gasoline'),
--     ('2.5 gasoline'),
--     ('3.0 gasoline'),
--     ('1.9 diesel'),
--     ('2.0 diesel'),
--     ('3.0 diesel'),
--     ('hybrid'),
--     ('electric'),
--     ('v8 gasoline');
--
-- INSERT INTO idea_db."505618".car_transmissions (name)
-- VALUES
--     ('manual 5-speed'),
--     ('manual 6-speed'),
--     ('automatic 6-speed'),
--     ('automatic 8-speed'),
--     ('robotic'),
--     ('cvt'),
--     ('dual clutch'),
--     ('single-speed electric');
--
-- INSERT INTO idea_db."505618".cars (name, body_id, engine_id, transmission_id)
-- VALUES
--     ('Toyota Corolla', 1, 1, 3),
--     ('Toyota Camry', 1, 2, 4),
--     ('Volkswagen Golf', 2, 1, 2),
--     ('Skoda Octavia', 10, 2, 4),
--     ('BMW 3 Series', 1, 3, 4),
--     ('BMW X5', 6, 7, 4),
--     ('Audi A4', 1, 2, 7),
--     ('Audi Q5', 5, 6, 7),
--     ('Mercedes C-Class', 1, 2, 4),
--     ('Mercedes GLE', 6, 7, 4),
--     ('Tesla Model 3', 1, 9, 8),
--     ('Tesla Model Y', 5, 9, 8),
--     ('Ford Focus', 2, 1, 2),
--     ('Ford Ranger', 7, 6, 3),
--     ('Mazda MX-5', 9, 2, 2),
--     ('Kia Sportage', 5, 2, 4),
--     ('Hyundai Tucson', 5, 6, 4),
--     ('Nissan Leaf', 2, 9, 8),
--     ('Lada Vesta', 1, 1, 1),
--     ('Concept Car A', NULL, 9, 8),
--     ('Concept Car B', 4, NULL, 7),
--     ('Prototype X', NULL, NULL, NULL),
--     ('Old Van', 8, 5, NULL);
--

--1) вывести кузова, которые не используются ни в одной машине.
SELECT b.id,
       b.name
FROM idea_db."505618".car_bodies b
LEFT JOIN idea_db."505618".cars c ON c.body_id = b.id
WHERE c.id IS NULL;

--2) вывести двигатели, которые не используются ни в одной машине.
SELECT e.id,
       e.name
FROM idea_db."505618".car_engines e
LEFT JOIN idea_db."505618".cars c ON c.engine_id = e.id
WHERE c.id IS NULL;

--3) вывести коробки передач, которые не используются ни в одной машине.
SELECT t.id,
       t.name
FROM idea_db."505618".car_transmissions t
LEFT JOIN idea_db."505618".cars c ON c.engine_id = t.id
WHERE c.id IS NULL;

--4) вывести список всех машин и название кузова, если оно указано.
SELECT c.id,
       c.name as car_name,
       b.name as body_name
FROM idea_db."505618".cars c
LEFT JOIN idea_db."505618".car_bodies b ON c.body_id = b.id

--5) вывести только те машины, у которых одновременно указаны:
-- кузов;
-- двигатель;
-- коробка передач.
--     машины, у которых хотя бы одна из деталей отсутствует, в результат попасть не должны.
SELECT c.id,
       c.name as car_name,
       b.name as body_name,
       e.name as engine_name,
       t.name as transmission_name
FROM idea_db."505618".cars c
JOIN idea_db."505618".car_bodies b ON b.id = c.body_id
JOIN idea_db."505618".car_engines e ON e.id = c.engine_id
JOIN idea_db."505618".car_transmissions t ON t.id = c.transmission_id;

--6) вывести машины, у которых есть двигатель, но нет кузова.
SELECT c.id,
       c.name as car_name,
       b.name as body_name,
       e.name as engine_name
FROM idea_db."505618".cars c
JOIN idea_db."505618".car_engines e ON e.id = c.engine_id
LEFT JOIN idea_db."505618".car_bodies b ON b.id = c.body_id
WHERE c.body_id IS NULL;

--7) вывести все кузова и машины, которые их используют.
SELECT b.id AS body_id,
       b.name AS body_name,
       c.id AS car_id,
       c.name AS car_name
FROM idea_db."505618".car_bodies b
LEFT JOIN idea_db."505618".cars c on b.id = c.body_id;

--8) вывести неиспользуемые двигатели.
SELECT e.id,
       e.name as engine_name
FROM idea_db."505618".car_engines e
LEFT JOIN idea_db."505618".cars c ON c.engine_id = e.id
WHERE c.engine_id IS NULL;

--9) вывести машины и все их детали, но только для машин с автоматической коробкой передач.
SELECT c.id,
       c.name as car_name,
       b.name as body_name,
       e.name as engine_name,
       t.name as transmission_name
FROM idea_db."505618".cars c
LEFT JOIN idea_db."505618".car_bodies b ON b.id = c.body_id
LEFT JOIN idea_db."505618".car_engines e ON e.id = c.engine_id
LEFT JOIN idea_db."505618".car_transmissions t ON t.id = c.transmission_id
WHERE t.name ILIKE 'automatic%';

--10) вывести машины, у которых отсутствует хотя бы одна деталь.
SELECT c.id,
       c.name as car_name,
       b.name as body_name,
       e.name as engine_name,
       t.name as transmission_name
FROM idea_db."505618".cars c
LEFT JOIN idea_db."505618".car_bodies b ON b.id = c.body_id
LEFT JOIN idea_db."505618".car_engines e ON e.id = c.engine_id
LEFT JOIN idea_db."505618".car_transmissions t ON t.id = c.transmission_id
WHERE c.body_id IS NULL
    OR c.engine_id IS NULL
    OR c.transmission_id IS NULL;


--11) вывести все машины с двигателями, но коробку передач подключить так, чтобы машины без коробки тоже попали в результат.
SELECT c.id,
       c.name as car_name,
       e.name as engine_name,
       t.name as transmission_name
FROM idea_db."505618".cars c
JOIN idea_db."505618".car_engines e ON e.id = c.engine_id
LEFT JOIN idea_db."505618".car_transmissions t ON t.id = c.transmission_id;

--12) вывести все неиспользуемые детали в едином формате.
SELECT 'body' AS detail_type,
       b.id AS detail_id,
       b.name AS detail_name
FROM idea_db."505618".car_bodies b
WHERE NOT EXISTS (
        SELECT 1
        FROM idea_db."505618".cars c
        WHERE c.body_id = b.id
    )

UNION ALL

SELECT 'engine' AS detail_type,
       e.id AS detail_id,
       e.name AS detail_name
FROM idea_db."505618".car_engines e
WHERE NOT EXISTS (
        SELECT 1
        FROM idea_db."505618".cars c
        WHERE c.engine_id = e.id
    )

UNION ALL

SELECT 'transmission' AS detail_type,
       t.id AS detail_id,
       t.name AS detail_name
FROM idea_db."505618".car_transmissions t
WHERE NOT EXISTS (
        SELECT 1
        FROM idea_db."505618".cars c
        WHERE c.transmission_id = t.id
    );

--13) вывести машины и детали только для кузовов определенных типов.
-- Нужно вывести машины, у которых кузов относится к одному из типов:
-- sedan
-- hatchback
-- suv
SELECT c.id,
       c.name as car_name,
       b.name as body_name,
       e.name as engine_name,
       t.name as transmission_name
FROM idea_db."505618".cars c
JOIN idea_db."505618".car_bodies b ON b.id = c.body_id
LEFT JOIN idea_db."505618".car_engines e ON e.id = c.engine_id
LEFT JOIN idea_db."505618".car_transmissions t ON t.id = c.transmission_id
WHERE b.name IN ('sedan', 'hatchback', 'suv')
