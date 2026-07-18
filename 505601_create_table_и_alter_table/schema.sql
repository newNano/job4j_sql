DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
   id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name       TEXT NOT NULL,
   email      TEXT NOT NULL UNIQUE,
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE products (
  id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name       TEXT NOT NULL,
  price      NUMERIC(12, 2) NOT NULL CHECK (price > 0),
  is_active  BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE orders (
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id    BIGINT NOT NULL,
    status     TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE order_items (
     id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     order_id    BIGINT NOT NULL,
     product_id  BIGINT NOT NULL,
     quantity    INTEGER NOT NULL CHECK (quantity > 0),
     unit_price  NUMERIC(12, 2) NOT NULL CHECK (unit_price > 0),
     CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders (id),
     CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products (id)
);