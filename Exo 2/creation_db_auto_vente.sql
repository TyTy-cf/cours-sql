-- Creation de la base de données 'auto_vente'
-- Avec ordre de création des tables en fonction des Foreign Key

-- Indications en provenance du diagramme UML : 
-- Point noir : not null
-- Point blanc : null

CREATE DATABASE auto_vente;

CREATE TABLE categories (
    id int(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE brands (
    id int(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE models (
    id int(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    category_id int(11) NOT NULL,
    brand_id int(11) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE sellers (
    id int(11) NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    email VARCHAR(127) NOT NULL,
    phone_number VARCHAR(10) DEFAULT NULL,
    location VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE listings (
    id int(11) NOT NULL AUTO_INCREMENT,
    creation_year date DEFAULT NULL,
    km int(11) DEFAULT NULL,
    price int(11) NOT NULL,
    description text DEFAULT NULL,
    title VARCHAR(255) NOT NULL,
    published_at datetime NOT NULL,
    model_id int(11) NOT NULL,
    seller_id int(11) NOT NULL,
    FOREIGN KEY (model_id) REFERENCES models(id),
    FOREIGN KEY (seller_id) REFERENCES sellers(id),    
    PRIMARY KEY (id)
);