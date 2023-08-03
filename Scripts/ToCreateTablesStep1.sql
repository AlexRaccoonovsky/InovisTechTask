USE [InovisTTOperative]
CREATE TABLE fact_sales
(
	customerId INT,
	productId INT,
	qty INT
);

CREATE TABLE dimension_products
(
	id INT,
	name VARCHAR(255),
	groupname VARCHAR(255)
);

CREATE TABLE dimension_customers
(
	id INT,
	name VARCHAR(255),
	country VARCHAR(255)
);