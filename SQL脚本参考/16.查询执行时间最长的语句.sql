/*
  ����˵��:��ѯִ��ʱ��������
  �޸�˵��:Created BY LY 2012-6-13
  ��ע˵��: ���ݵļ��ݼ����� 100���ϣ�����Ҫ�� 
*/
SELECT  TOP 5 execution_count,
       ( total_elapsed_time / execution_count / 1000 ) avg_time,
       [text]
FROM   sys.dm_exec_query_stats qs
       CROSS APPLY sys.Dm_exec_sql_text(qs.sql_handle) AS st
ORDER  BY avg_time DESC 
