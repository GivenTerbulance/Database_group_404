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
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);
CREATE TABLE Address_status(
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
