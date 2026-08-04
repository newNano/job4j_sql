--в users добавляем столбцы:
ALTER TABLE idea_db."505601".users
ADD COLUMN phone TEXT,
ADD COLUMN middle_name TEXT;

--в products добавляем столбцы:
ALTER TABLE idea_db."505601".products
ADD COLUMN description TEXT,
ADD COLUMN discount_price NUMERIC(12, 2);

-- вывести всех пользователей, у которых не заполнено отчество. В результатах отражаем колонки: id, name, middle_name
SELECT id, name, middle_name
FROM idea_db."505601".users
WHERE middle_name IS NULL;

--вывести все товары, у которых отсутствует описание. В результатах отражаем колонки: id, name, description
SELECT id, name, description
FROM idea_db."505601".products
WHERE description IS NULL;

--вывести все товары, у которых нет скидочной цены. В результатах отражаем колонки: id, name, price, discount_price
SELECT id, name, discount_price
FROM idea_db."505601".products
WHERE discount_price IS NULL;

--вывести пользователей, у которых телефон либо NULL, либо пустая строка. В результатах отражаем колонки: id, name, phone
SELECT id, name, phone
FROM idea_db."505601".users
WHERE phone IS NULL OR phone = '';

--вывести список товаров и колонку display_description, где:
-- если description заполнено - показать его;
-- иначе вывести текст 'описание отсутствует'.
SELECT id,
       name,
       COALESCE(description, 'описание отсутствует') AS display_description
FROM idea_db."505601".products;

--вывести список товаров и колонку final_price, где:
-- если есть discount_price, использовать ее;
-- иначе брать price.
SELECT id,
       name,
       price,
       COALESCE(discount_price, 0) AS discount_price,
       COALESCE(discount_price, price) AS final_price
FROM idea_db."505601".products