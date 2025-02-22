/*
MEMORY OPTIMIZED TABLES  (MOT) :
A TECHNIQUE TO PRE-LOAD THE TABLE DATA INTO MEMORY BY USING "FILESTREAM" FILES.
IN-MEMORY PROCESSING.

ADVANTAGE:	FASTER INDEXING
			FASTER ACCESS TO ROW LEVEL DATA  = ROW STORE 
			FASTER CALCULATIONS, AGGREGATIONS AND DML OPERATIONS 

STEPS TO IMPLEMENT MEMORY OPTIMIZED TABLES [MOT TABLES]:
		STEP 1: ENABLE MEMORY OPTIMIZATION ON THE DATABASE
		STEP 2: DEFINE A MEMORY OPTIMIZED ENABLED FILEGROUP
		STEP 3: ADD FILESTREAM FILE TO ABOVE FILEGROUP
		STEP 4: DEFINE TABLE(S) USING ABOVE FILEGROUP
		STEP 5: UPDATE THE STATISTICS
*/

-- STEP 1: ENABLE MEMORY OPTIMIZATION PROPERTY ON THE DATABASE.
-- AVAILABLE FOR SQL SERVER 2016 AND HIGHER VERSIONS
USE MASTER 
GO
CREATE DATABASE [PRODUCT_DATABASE1]
GO
ALTER DATABASE  [PRODUCT_DATABASE1] SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = ON  



-- STEP 2: DEFINE A NEW FILEGROUP AND ENABLE IT FOR MOT TABLES
ALTER DATABASE [PRODUCT_DATABASE1] ADD FILEGROUP MOT_FG  CONTAINS MEMORY_OPTIMIZED_DATA 



-- STEP 3: ADD ATLEAST ONE FILE (FILESTREAM) TO ABOVE FILEGROUP
ALTER DATABASE [PRODUCT_DATABASE1] ADD FILE (name='imoltp_mod', filename='C:\imoltpmod')  TO FILEGROUP MOT_FG  
 

USE [PRODUCT_DATABASE1]


 -- STEP 4: CREATE TABLE USING MEMORY OPTIMIZATION SETTINGS
CREATE TABLE dbo.ShoppingCart
	(   
    ShoppingCartId INT IDENTITY(1,1) PRIMARY KEY NONCLUSTERED,    -- MANDATORY
    UserId INT NOT NULL INDEX ix_UserId NONCLUSTERED,   
    CreatedDate DATETIME NOT NULL,   
    TotalPrice MONEY  
    ) WITH (MEMORY_OPTIMIZED=ON)   
  GO  
  
INSERT dbo.ShoppingCart VALUES (8798, SYSDATETIME(), NULL) ,  (23, SYSDATETIME(), 45.4)  , (80, SYSDATETIME(), NULL)   
INSERT dbo.ShoppingCart VALUES (342, SYSDATETIME(), 65.4)   
GO  

select * from ShoppingCart		-- PREEMPTIVE CACHING : PRELOAD THE DATA INTO MEMORY FOR FASTER OPERATIONS.


-- STEP 5: DEFINE / UPDATE STATISTICS ON ABOVE TABLE.
UPDATE STATISTICS dbo.ShoppingCart WITH FULLSCAN	 -- All data pages for this table are scanned & updated 








