/*Script Purpose:
This script creates a new database named ' Olist_DataWarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated.
Additionally , the scripts sets schemas within the database : 'brown', 'silver', and gold'.

WARNING:
Running this script will drop the entire 'Olist_DataWarehouse' database if it exists.
All data in the database will be permanently deleted.
Proceed with caution and ensure you have proper backups before running this script.*/
USE master;
GO
 -- Delete and recreate the 'Olist_DataWarehouse' database
 IF EXISTS (SELECT 1 FROM sys.databases WHERE name='Olist_DataWarehouse')
 BEGIN
 ALTER DATABASE Olist_DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	 DROP DATABASE Olist_DataWarehouse;
	 END;
--Create the 'DataWarehouse' database
CREATE DATABASE Olist_DataWarehouse;
GO
USE Olist_DataWarehouse;
GO

/* We have 3 layers in our Olist_datawarehouse structure - Bronze, Silver and Gold. We are going to create 3 schemas for the layers.*/

CREATE SCHEMA bronze;
GO --Seperator
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
