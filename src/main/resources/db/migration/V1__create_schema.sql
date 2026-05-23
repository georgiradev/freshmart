-- V1: Initial schema creation

CREATE TABLE IF NOT EXISTS CATEGORY (
    category_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS CUSTOMER (
    id       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    address  VARCHAR(255),
    email    VARCHAR(255),
    password VARCHAR(255),
    role     VARCHAR(255),
    username VARCHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS PRODUCT (
    product_id  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(255),
    image       VARCHAR(255),
    name        VARCHAR(255),
    price       INT,
    quantity    INT,
    weight      INT,
    category_id INT,
    customer_id INT,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES CATEGORY (category_id),
    CONSTRAINT fk_product_customer FOREIGN KEY (customer_id) REFERENCES CUSTOMER (id)
);

CREATE TABLE IF NOT EXISTS CART (
    id          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT,
    CONSTRAINT fk_cart_customer FOREIGN KEY (customer_id) REFERENCES CUSTOMER (id)
);

CREATE TABLE IF NOT EXISTS CART_PRODUCT (
    id         INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cart_id    INT,
    product_id INT,
    CONSTRAINT fk_cartproduct_cart    FOREIGN KEY (cart_id)    REFERENCES CART (id),
    CONSTRAINT fk_cartproduct_product FOREIGN KEY (product_id) REFERENCES PRODUCT (product_id)
);
