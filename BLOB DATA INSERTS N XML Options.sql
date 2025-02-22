USE [PRODUCT DATABASE]

CREATE TABLE tblStore
(
id int identity,
content varbinary(max)			-- THIS COLUMN CAN STORE UPTO 2 GB DATA PER VALUE. 
)

-- BLOB : BINARY LARGE OBJECT DATA
INSERT INTO tblStore(content) 
			SELECT bulkcolumn FROM OPENROWSET(BULK 'D:\SQL SERVER DATA TYPES.docx', SINGLE_BLOB) 
			AS SubQuery			-- THIS IS FOR CORRELATION = CORRELATED SUB QUERY

INSERT INTO tblStore(content) 
			SELECT bulkcolumn FROM OPENROWSET(BULK 'E:\SQL-Server-Online-Training.pdf', SINGLE_BLOB) 
			AS SubQuery

SELECT COUNT(*) FROM tblStore
SELECT * FROM tblStore

EXEC SP_SPACEUSED 'tblStore'




SELECT * FROM SheepCountingWords

SELECT * FROM SheepCountingWords  FOR XML AUTO		-- EACH ROW IS A LINE. TABLE NAME IS THE XML TAG NAME

SELECT * FROM SheepCountingWords FOR XML RAW		-- EACH ROW IS A LINE. "ROW" IS THE XML TAG NAME

SELECT * FROM SheepCountingWords FOR XML PATH		-- EACH ROW IS A XML TREE. "ROW" IS THE XML TAG NAME



-- NEXT CHAPTER	:	 BANKING PROJECT
-- YOU SHALL BE GIVEN THE REQUIREMENT ON EMAIL. YOU SHALL BE SUBMITTING YOUR SOLUTIONS PHASE BY PHASE.
			-- PHASE 1	:	DESIGN OF THE BANKING SYSTEM
			-- PHASE 2	:	QUERY WRITING
			-- PHASE 3	:	PROGRAMMING & FUNCTIONS, PIVOTS, ETC..
			-- PHASE 4	:	RESUME POINTS UPTO T-SQL PLAN B CLASSES.

			saiphanindrait@gmail.com 