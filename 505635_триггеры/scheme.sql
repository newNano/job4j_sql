--2) Создайте таблицу employees. Таблица должна содержать следующие поля:
CREATE TABLE idea_db."505635".employees (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    salary NUMERIC(12, 2) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Создание тригерной функции
CREATE OR REPLACE FUNCTION idea_db."505635".update_employee_updated_at()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

--Создание тригера
CREATE TRIGGER employees_updated_at_trigger
BEFORE UPDATE ON idea_db."505635".employees
FOR EACH ROW
EXECUTE FUNCTION idea_db."505635".update_employee_updated_at();

--3)Создайте таблицу orders и таблицу order_status_history.
-- При каждом изменении статуса заказа необходимо автоматически сохранять:
-- идентификатор заказа;
-- предыдущий статус;
-- новый статус;
-- дату изменения.
CREATE TABLE idea_db."505635".orders (
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    status     TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE idea_db."505635".order_status_history (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL,
    old_status TEXT NOT NULL,
    new_status TEXT NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--создание триггерной функции
CREATE OR REPLACE FUNCTION idea_db."505635".save_order_status_history()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO idea_db."505635".order_status_history (
        order_id,
        old_status,
        new_status
    )
    VALUES (
        OLD.id,
        OLD.status,
        NEW.status
    );
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
--создание триггера
CREATE TRIGGER order_status_history_trigger
AFTER UPDATE OF status
ON idea_db."505635".orders
FOR EACH ROW
EXECUTE FUNCTION idea_db."505635".save_order_status_history();

--4) Используйте таблицу employees.
--Необходимо запретить сохранение сотрудников с отрицательной заработной платой.
-- Реализуйте триггер, который будет выдавать ошибку при попытке выполнить INSERT или UPDATE с некорректным значением.

--создание функции
CREATE OR REPLACE FUNCTION idea_db."505635".check_employee_salary()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.salary < 0 THEN
        RAISE EXCEPTION 'Заработная плата не может быть отрицательной';
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

--создание тригера
CREATE TRIGGER check_employee_salary_trigger
BEFORE INSERT OR UPDATE
ON idea_db."505635".employees
FOR EACH ROW
EXECUTE FUNCTION idea_db."505635".check_employee_salary();

--5) в таблице products имеется поле name
--Реализуйте триггер, который автоматически удаляет пробелы в начале и конце названия товара перед сохранением записи.
--создаем таблицу
CREATE TABLE idea_db."505635".products (
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       TEXT NOT NULL,
    price      NUMERIC(12, 2) NOT NULL CHECK (price > 0),
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

--создание функции
CREATE OR REPLACE FUNCTION idea_db."505635".trim_product_name()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.name := BTRIM(NEW.name);
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

--создание триггера
CREATE TRIGGER trim_product_name_trigger
BEFORE INSERT OR UPDATE
ON idea_db."505635".products
FOR EACH ROW
EXECUTE FUNCTION idea_db."505635".trim_product_name();


--6) В таблице products хранится поле price.
-- Необходимо реализовать журнал изменения цены таким образом, чтобы новая запись в журнал добавлялась только тогда,
-- когда цена действительно изменилась.
-- Если обновляются другие поля товара, история цен пополняться не должна.
CREATE TABLE idea_db."505635".product_price_history (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT NOT NULL,
    old_price NUMERIC(12, 2) NOT NULL,
    new_price NUMERIC(12, 2) NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

--создание функции
CREATE OR REPLACE FUNCTION idea_db."505635".save_product_price_history()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO idea_db."505635".product_price_history (
        product_id,
        old_price,
        new_price
    )
    VALUES (
       OLD.id,
       OLD.price,
       NEW.price
   );
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

--создание триггера
CREATE TRIGGER product_price_history_trigger
AFTER UPDATE OF price
ON idea_db."505635".products
FOR EACH ROW
WHEN (OLD.price IS DISTINCT FROM NEW.price)
EXECUTE FUNCTION idea_db."505635".save_product_price_history();