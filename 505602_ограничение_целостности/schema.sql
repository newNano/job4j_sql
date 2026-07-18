-- Роли пользователей
CREATE TABLE roles
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE CHECK (BTRIM(name) != '')
);


-- Состояния заявок
CREATE TABLE states
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE CHECK (BTRIM(name) != '' AND
                                     name IN ('NEW',
                                              'IN_PROGRESS',
                                              'RESOLVED',
                                              'CANCELLED'))
);


-- Пользователи
CREATE TABLE users
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login TEXT NOT NULL UNIQUE CHECK (BTRIM(login) != ''),
    password_hash TEXT NOT NULL CHECK (BTRIM(password_hash) != ''),
    role_id BIGINT NOT NULL,
    CONSTRAINT fk_users_roles FOREIGN KEY (role_id) REFERENCES roles (id)
);


-- Категории заявок
CREATE TABLE categories
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE CHECK (BTRIM(name) != '')
);


-- Заявки
CREATE TABLE items
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL CHECK (BTRIM(title) != ''),
    description TEXT NOT NULL CHECK (BTRIM(description) != ''),
    author_id BIGINT NOT NULL,
    state_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,

    CONSTRAINT fk_items_users FOREIGN KEY (author_id) REFERENCES users (id),
    CONSTRAINT fk_items_states FOREIGN KEY (state_id) REFERENCES states (id),
    CONSTRAINT fk_items_categories FOREIGN KEY (category_id) REFERENCES categories (id)
);

-- Комментарии
CREATE TABLE comments
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    content TEXT NOT NULL CHECK (BTRIM(content) != ''),
    author_id BIGINT NOT NULL,
    item_id BIGINT NOT NULL,

    CONSTRAINT fk_comments_users FOREIGN KEY (author_id) REFERENCES users (id),
    CONSTRAINT fk_comments_items FOREIGN KEY (item_id) REFERENCES items (id)
);