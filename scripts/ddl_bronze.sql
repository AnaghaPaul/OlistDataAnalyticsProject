/*
=====================================================================================================
DDL Script: Create Bronze Tables
=====================================================================================================
Purpose : This script creates 9 empty tables in bronze layer and drop the tables if they already exists. 
This is the step before 'Full load' of data into the bronze layer
Warning : The existing tables and data in it would be deleted when the script is executed.
Properties : The layer is designed to favour flexibity over storage to make data ingestion process easier and successfull.
             The layer has most of the columns defined to accept varchar data and allocating a bit more storage than it is usually expected.
             The layer has also has all place and comment columns defined to be nvarchar to conserve data accuracy and considering language aspects.*/
USE Olist_DataWarehouse;
GO
--Creating Empty Tables
--olist_customers_dataset table --naming convention- remove reduntant words like olist, dataset, keep only customers
-- customers table
IF OBJECT_ID('bronze.customers','U')  IS NOT NULL
	DROP TABLE bronze.customers;
CREATE TABLE bronze.customers(
	customer_id VARCHAR(50),
	customer_unique_id VARCHAR(50),
	customer_zip_code_prefix VARCHAR(10),
	customer_city NVARCHAR(50),
	customer_state VARCHAR(5)
)

-- olist_geolocation_dataset.csv

--geolocation table
IF OBJECT_ID('bronze.geolocation','U') IS NOT NULL
	DROP TABLE bronze.geolocation;

CREATE TABLE bronze.geolocation(
	geolocation_zip_code_prefix VARCHAR(10),
	geolocation_lat VARCHAR(50),
	geolocation_lng VARCHAR(50),
	geolocation_city NVARCHAR(50),
	geolocation_state VARCHAR(5)
)
--olist_order_items_dataset.csv

--order_items table
IF OBJECT_ID('bronze.order_items','U') IS NOT NULL
	DROP TABLE bronze.order_items;

CREATE TABLE bronze.order_items(
order_id VARCHAR(50),
order_item_id INT,
product_id VARCHAR(50),
seller_id VARCHAR(50),
shipping_limit_date DATETIME,
price VARCHAR(10),--decimal can be too strict
freight_value VARCHAR(10) --shipping cost for an item in an order
)

-- olist_order_payments_dataset
--order_payments table
IF OBJECT_ID('bronze.order_payments','U') IS NOT NULL
	DROP TABLE bronze.order_payments;
CREATE TABLE bronze.order_payments(
	order_id CHAR(32),
	payment_sequential INT,
	payment_type VARCHAR(20),
	payment_installments INT,
	payment_value DECIMAL(10,2)
)

--olist_order_reviews_dataset.csv
-- order_reviews table
IF OBJECT_ID('bronze.order_reviews', 'U') IS NOT NULL
	DROP TABLE bronze.order_reviews;
CREATE TABLE bronze.order_reviews(
	review_id CHAR(32),
	order_id CHAR(32),
	review_score TINYINT,
	review_comment_title NVARCHAR(100),--accents
	review_comment_message NVARCHAR(MAX),
	review_creation_date DATETIME,
	review_answer_timestamp DATETIME
)

--olist_orders_dataset

--orders table

IF OBJECT_ID('bronze.orders','U') IS NOT NULL
	DROP TABLE bronze.orders;
CREATE TABLE bronze.orders(
	order_id CHAR(32),
	customer_id CHAR(32),
	order_status VARCHAR(20),
	order_purchase_timestamp DATETIME,
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME
)

--olist_products_dataset.csv

--products table

IF OBJECT_ID('bronze.products','U') IS NOT NULL
	DROP TABLE bronze.products;
CREATE TABLE bronze.products(
	product_id CHAR(32),
	product_category_name NVARCHAR(50),
	product_name_lenght INT, --length, rename column later
	product_description_length INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
)

--olist_sellers_dataset.csv
--sellers table
IF OBJECT_ID('bronze.sellers','U') IS NOT NULL
	DROP TABLE bronze.sellers;
CREATE TABLE bronze.sellers(
	seller_id  CHAR(32),
	seller_zip_code_prefix CHAR(5), --not int because values similar to 04195 exists
	seller_city NVARCHAR(50),
	seller_state CHAR(2)
)

--product_category_name_translation.csv
--product_category_name_translation table
IF OBJECT_ID('bronze.product_category_name_translation','U') IS NOT NULL
	DROP TABLE bronze.product_category_name_translation;
CREATE TABLE bronze.product_category_name_translation(
	product_category_name NVARCHAR(50),
	product_category_name_english VARCHAR(50)
)
