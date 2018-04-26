/*
	����˵����  ��DBCC�Ľ�����浽�����棬����ѧϰWITH tableresults������ʹ��
	�޸�˵����	Create by LY on 2012-5-30
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
