/*
  功能说明:查询耗时最长进程的CPU语句
  修改说明:Created BY LY 2012-6-13
*/
DECLARE @Plan_Handle_SQL VARBINARY(64);

SELECT TOP 1 @Plan_Handle_SQL = qs.plan_handle
FROM   sys.dm_exec_query_stats qs
GROUP  BY qs.plan_handle,
          qs.sql_handle
ORDER  BY Sum(qs.total_worker_time) DESC

SELECT text
FROM   sys.Dm_exec_sql_text(@Plan_Handle_SQL) 
