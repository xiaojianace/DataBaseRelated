

/*
 功能说明:清空缓存
*/
DBCC DROPCLEANBUFFERS 
DBCC FREEPROCCACHE 

/*
 功能说明:重建索引，整理索引碎片
*/
DBCC SHOWCONTIG(QDTHD)
DBCC DBREINDEX(QDTHD)
/*
 功能说明:更新统计信息
*/
update statistics QDTHD
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
/*
  功能说明: 重建整个库的统计信息
  修改说明: Created BY LY 2012-6-14
*/
Exec sp_updatestats;