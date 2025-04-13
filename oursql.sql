
DROP DATABASE IF EXISTS BookStore;
CREATE DATABASE BookStore;
USE BookStore;
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT
);


CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    website VARCHAR(100)
);

CREATE TABLE book(
     book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    publisher_id INT,
    language_id INT,
    publication_year INT,
    price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

SHOW DATABASES;

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
CREATE TABLE Customer(
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name varchar (25) NOT NULL,
    customer_surname varchar (25) NOT NULL,
    customer_email varchar (25) UNIQUE
);
CREATE TABLE Customer_Address(
	customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_status_id INT,
    address_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id),
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);
CREATE TABLE address_status(
	address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    address_status_name varchar(50) NOT NULL
);
CREATE TABLE Address(
	address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_name varchar(50),
    address_street varchar(30),
    address_town varchar(50),
    address_postal_code varchar(20),
    address_state_province varchar (30),
    address_status_id INT,
    country_id INT,
    customer_id INT,
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id),
    FOREIGN KEY (country_id) REFERENCES country (country_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
CREATE TABLE country(
	country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name varchar (30) NOT NULL
);
CREATE TABLE customer_order(
	customer_order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,  
    address_status_id INT,
    shipping_method_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_quantity INT NOT NULL,
    price_total INT NOT NULL,
  
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);
CREATE TABLE order_line(
     order_line_id INT AUTO_INCREMENT PRIMARY KEY,
     customer_order_id INT,
     book_id INT,
     FOREIGN KEY (customer_order_id) REFERENCES customer_order(customer_order_id),
	 FOREIGN KEY (book_id) REFERENCES book(book_id)
     );
CREATE TABLE shipping_method(
	shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(20) NOT NULL,
    cost DEC (10,2),
    customer_id INT,
    country_id INT,
    status_id INT,
    order_status_id INT,
    address_id INT,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (country_id) REFERENCES country(country_id),
	FOREIGN KEY (status_id) REFERENCES order_status(status_id),
	FOREIGN KEY (address_id) REFERENCES address(address_id)
);
CREATE TABLE order_history(
	order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_order_id INT,
    status_id INT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_order_id) REFERENCES customer_order(customer_order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

SHOW TABLES;
DROP TABLE shipping_order;
SELECT GROUP_CONCAT(table_name SEPARATOR ', ') 
FROM information_schema.tables 
WHERE table_schema = DATABASE();

-- Creating User Roles and Permissions 
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonly123';

GRANT SELECT ON BookStoreDB.* TO 'readonly_user'@'localhost';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass123';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'admin_user'@'localhost';
FLUSH PRIVILEGES;

-- Sample data for tesing(Inserting our samble data) 

INSERT INTO author (name, bio) VALUES
('J.K. Rowling', 'British author, best known for the Harry Potter series.'),
('George R.R. Martin', 'American novelist and short story writer, author of A Song of Ice and Fire.'),
('Chinua Achebe', 'Nigerian novelist, poet, professor, and critic.');

INSERT INTO book_language (language_name) VALUES
('English'),
('French'),
('Spanish');

INSERT INTO publisher (name, website) VALUES
('Penguin Random House', 'https://www.penguinrandomhouse.com'),
('HarperCollins', 'https://www.harpercollins.com'),
('Macmillan Publishers', 'https://us.macmillan.com');

INSERT INTO book (title, publisher_id, language_id, publication_year, price, stock_quantity) VALUES
('Harry Potter and the Sorcerer\'s Stone', 1, 1, 1997, 19.99, 50),
('A Game of Thrones', 2, 1, 1996, 24.99, 30),
('Things Fall Apart', 3, 1, 1958, 14.99, 40);

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO customer (customer_name, customer_surname, customer_email) VALUES
('Nontando', 'Myoli', 'nontando.myoli@9.com'),
('Aran', 'Loid', 'aran.loid@8.com'),
('given', 'ikaneng', 'given.ikaneng@6.com');

INSERT INTO address_status (address_status_name) VALUES
('Home'),
('Work'),
('Billing');

INSERT INTO country (country_name) VALUES
('United States'),
('United Kingdom'),
('Nigeria');

INSERT INTO order_status (status_name) VALUES
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');






















