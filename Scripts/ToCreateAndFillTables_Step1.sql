USE [AdventureWorks2022]
-- to delete temporary tables if its exist
DROP TABLE IF EXISTS products_temp;
DROP TABLE IF EXISTS sales_temp;
DROP TABLE IF EXISTS customers_temp;
-- to create temporary table "products" and fill it
SELECT
	ProductID,
	Name,
	ProductLine
INTO products_temp
FROM [Production].[Product]
WHERE ProductLine IS NOT NULL AND ProductSubcategoryID IS NOT NULL;

-- to create temporary table "customers" and fill it
SELECT TOP(100)
	BusinessEntityID,
	FirstName
INTO customers_temp
FROM [Person].[Person]
WHERE MiddleName IS NOT NULL;

--to append "country" column & fill (random)

ALTER TABLE [dbo].[customers_temp]
ADD Country NVARCHAR(50);

UPDATE [dbo].[customers_temp]
SET  Country = 'Argentina'
WHERE LEN(FirstName)>4;

UPDATE [dbo].[customers_temp]
SET  Country = 'Israel'
WHERE LEN(FirstName)<=4;

--to select InovisTTOperative
USE [InovisTTOperative]
-- to clear (delete) tables: dimension_products 
DROP TABLE IF EXISTS [dbo].[dimension_products];
DROP TABLE IF EXISTS [dbo].[dimension_customers];
DROP TABLE IF EXISTS [dbo].[fact_sales];

-- to create table "dimension_products"
CREATE TABLE [dbo].[dimension_products]
(
    id INT,
    name VARCHAR(255),
	groupname VARCHAR(255)
);

-- to create table "dimension_customers"
CREATE TABLE [dbo].[dimension_customers]
(
    id INT,
    name VARCHAR(255),
	country VARCHAR(50)
);

--to copy data from temporary table "products_temp" to "dimension_products"
INSERT INTO [dbo].[dimension_products] (id, name, groupname)
SELECT 
	ProductID,
	Name,
	ProductLine
FROM 
	[AdventureWorks2022].[dbo].[products_temp];

--to copy data from temporary table "customers_temp" to "dimension_customers"
INSERT INTO [dbo].[dimension_customers] (id, name, country)
SELECT 
	BusinessEntityID,
	FirstName,
	Country
FROM 
	[AdventureWorks2022].[dbo].[customers_temp];



--to look on temporary table
USE  [InovisTTOperative]
SELECT
*
FROM
[dbo].[dimension_customers]