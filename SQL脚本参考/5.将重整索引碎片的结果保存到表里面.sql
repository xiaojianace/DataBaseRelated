/*
	功能说明：  将DBCC的结果保存到表里面，并且学习WITH tableresults函数的使用
	修改说明：	Create by LY on 2012-5-30
*/
--IF object_id('tempdb..#showContigResults') IS NOT NULL
--BEGIN
--drop table tempdb..#showContigResults
--END
DECLARE @Table Table (

     ObjectName          SYSNAME,
     Objectid            BIGINT,
     IndexName           SYSNAME,
     indexid             INT,
     [level]             INT,
     pages               INT,
     [rows]              BIGINT,
     minRecsize          INT,
     maxRecsize          INT,
     avgRecSize          REAL,
     ForwardRecs         INT,
     Extents             INT,
     ExtentSwitches      INT,
     AvgFreeBytes        REAL,
     AvgPageDensity      REAL,
     ScanDensity         DECIMAL(5, 2),
     BestCount           INT,
     ActCount            INT,
     LogicalFrag         DECIMAL (5, 2),
     ExtentFragmentation DECIMAL (5, 2)
)
INSERT INTO @Table
EXEC('DBCC SHOWCONTIG (''SG_Gatherings'') WITH tableresults')

SELECT LogicalFrag
FROM   @Table


--DBCC SHOWCONTIG ('SG_Gatherings')WITH tableresults 
