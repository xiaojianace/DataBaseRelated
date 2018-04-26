/*
     功能说明:查询所有文件组
*/


SELECT name,type_desc
FROM SYS.filegroups 


/*
     功能说明:查询所有文件及文件对应的路径
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