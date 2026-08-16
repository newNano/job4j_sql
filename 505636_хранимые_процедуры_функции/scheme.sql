--создайте функцию calculate_discount, которая принимает два параметра:
CREATE OR REPLACE FUNCTION calculate_discount(
    price NUMERIC,
    discount_percent NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
AS
$$
    SELECT price * (100 - discount_percent) / 100;
$$;
--проверка работы функции
SELECT calculate_discount(2500, 15);

--создайте функцию full_name, которая принимает имя и фамилию пользователя и возвращает строку в формате:
CREATE OR REPLACE FUNCTION full_name(
    first_name TEXT,
    last_name TEXT
)
RETURNS TEXT
LANGUAGE SQL
AS
$$
    SELECT CONCAT(first_name, ' ', last_name);
$$;
--проверка
SELECT full_name('Иван', 'Иванов');

--создайте процедуру increase_category_prices, которая принимает:
-- название категории товаров;
-- процент увеличения цены.
-- Процедура должна увеличить стоимость всех товаров указанной категории на заданный процент.
--
-- После создания процедуры проверьте ее работу с помощью команды CALL.
CREATE OR REPLACE PROCEDURE increase_category_prices(
    category_name TEXT,
    percent NUMERIC
)
LANGUAGE SQL
AS
$$
    UPDATE idea_db."505621".products p
    SET price = price * (100 + percent) / 100
    WHERE p.category = category_name;
$$;

CALL increase_category_prices('Электроника', 10);


--создайте процедуру archive_old_orders.
-- Процедура должна перенести все заказы, созданные более года назад, из таблицы orders в таблицу orders_archive, а затем удалить их из таблицы orders.
CREATE TABLE idea_db."505636".orders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE idea_db."505636".orders_archive (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE OR REPLACE PROCEDURE archive_old_orders()
LANGUAGE plpgsql
AS
$$
BEGIN
    WITH archived_orders AS (
        INSERT INTO idea_db."505636".orders_archive(
            id,
            user_id,
            created_at
       )
       SELECT o.id, o.user_id, o.created_at
       FROM idea_db."505636".orders o
       WHERE CURRENT_TIMESTAMP > created_at + INTERVAL '1 year'
       RETURNING id
    )
    DELETE FROM idea_db."505636".orders o
    WHERE o.id IN (SELECT ao.id FROM archived_orders ao);
END;
$$;

CALL archive_old_orders();


--для каждой ситуации ниже определите, что следует использовать - функцию или процедуру:
--Необходимо вычислить стоимость товара с учетом скидки и вывести ее в запросе SELECT.  (функция, т.к нужно вычислить и вывести в SELECT)
--Необходимо раз в месяц увеличить зарплату всем сотрудникам отдела на заданный процент. (процедура, т.к работа по изменению данных в таблице)
--Необходимо получить полное имя пользователя из имени и фамилии. (функция, т.к здесь вывод данных)
--Необходимо перенести старые записи из рабочей таблицы в архив.  (процедура, т.к работа по изменению данных в таблице)
--Необходимо вычислить сумму налога для каждого заказа при выполнении SQL-запроса.  (функция, т.к нужно вычислить)
