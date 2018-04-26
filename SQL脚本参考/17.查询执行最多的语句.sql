/*
  功能说明:查询执行最多的语句
  修改说明:Created BY LY 2012-6-13
  备注说明: 数据的兼容级别是 100以上，很重要的 
*/
SELECT execution_count,
       ( total_elapsed_time / execution_count / 1000 ) avg_time,
       [text]
FROM   sys.dm_exec_query_stats qs
       CROSS APPLY sys.Dm_exec_sql_text(qs.sql_handle) AS st
ORDER  BY execution_count DESC 
