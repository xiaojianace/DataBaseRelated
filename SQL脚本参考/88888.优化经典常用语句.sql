

/*
 ����˵��:��ջ���
*/
DBCC DROPCLEANBUFFERS 
DBCC FREEPROCCACHE 

/*
 ����˵��:�ؽ�����������������Ƭ
*/
DBCC SHOWCONTIG(QDTHD)
DBCC DBREINDEX(QDTHD)
/*
 ����˵��:����ͳ����Ϣ
*/
update statistics QDTHD
/*
  ����˵��: �ؽ��������������Ƭ
  �޸�˵��: Created BY LY 2012-6-14
*/
DECLARE @SQL VARCHAR(MAX)
SET @SQL = ''
SELECT @SQL = @SQL + 'DBCC DBREINDEX(' + name + ');'
FROM   sysobjects
WHERE  xtype = 'u'
EXEC(@SQL) 
/*
  ����˵��: �ؽ��������ͳ����Ϣ
  �޸�˵��: Created BY LY 2012-6-14
*/
Exec sp_updatestats;