/*
     ����˵��:��ѯ�����ļ���
*/


SELECT name,type_desc
FROM SYS.filegroups 


/*
     ����˵��:��ѯ�����ļ����ļ���Ӧ��·��
*/
SELECT name,type_desc,physical_name,state_desc,size,growth
FROM SYS.database_files
WHERE type_desc ='ROWS'






--SELECT *
--FROM SYS.database_files
--WHERE type_desc ='ROWS'

--sp_spaceused SHANGPIN

--Execute sp_help  SHANGPIN


--select * from information_schema.tables where table_type='SHANGPIN' 