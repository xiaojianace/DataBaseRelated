/*
  功能说明: 重建整个库的索引碎片
  修改说明: Created BY LY 2012-6-14
*/
DECLARE @SQL VARCHAR(MAX)
SET @SQL = ''
SELECT @SQL = @SQL + 'DBCC DBREINDEX(' + name + ');'
FROM   sysobjects
WHERE  xtype = 'u'
EXEC(@SQL) 
