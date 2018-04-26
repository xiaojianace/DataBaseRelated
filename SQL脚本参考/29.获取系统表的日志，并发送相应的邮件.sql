/*
	功能说明: 系统表中的日志
	修改说明：Create by LY on 2011-10-10
*/
DECLARE @TableHTML  NVARCHAR(MAX);  
SET @TableHTML =
    N'<H1 align="center">System日志列表</H1>' +
    N'<table border="1" cellspacing="0" cellPadding="5" style="line-height:25px; font-size:13px;">' +
    N'<tr style="background:#e1e1e1;"><th nowrap>作业名称</th>' +
    N'<th nowrap>作业开始时间</th><th nowrap>作业结束日期</th><th nowrap>日志详情</th>' +
    N'</tr>' +
    CAST((SELECT td = jobs.name,      '',
                    td = CONVERT(VARCHAR,jobs.date_created,120), '',
                    td = CONVERT(VARCHAR,jobs.date_modified,120), '',
                    td = history.message, ''
              FROM msdb.dbo.sysjobhistory history
              INNER JOIN msdb.dbo.sysjobs jobs
              ON history.job_id=jobs.job_id
              WHERE jobs.name = 'AAAA' AND step_id <> 0 AND run_status = 0
              AND CONVERT(DATE,date_created) = CONVERT(DATE,GETDATE()) 
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;
IF( @TableHTML IS NULL)
 BEGIN
  SELECT 1
 END
ELSE
 BEGIN
  EXEC msdb.dbo.sp_send_dbmail 
	@profile_name = 'AAAAProfile',
	@recipients = 'liangyong1107@126.com',
	@subject = '系统功能测试',
	@body = @tableHTML,
	@body_format =  'HTML' ;
	SELECT 0
END