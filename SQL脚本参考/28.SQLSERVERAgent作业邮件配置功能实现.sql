/*
  功能说明:数据库邮件信息配置
  修改说明:Created BY LY 2012-7-6
*/
DECLARE @Advanced_Options VARCHAR(35) = 'SHOW ADVANCED OPTIONS',
        @XP_CMDShell      VARCHAR(35) = 'xp_cmdshell',
        @Net_Stop_Agent   VARCHAR(50),
        @Net_Start_Agent  VARCHAR(50);

SELECT @Net_Stop_Agent = CASE
                           WHEN @@SERVICENAME = 'MSSQLSERVER' THEN 'NET STOP SQLSERVERAGENT'
                           ELSE 'NET STOP SQLAgent$' + @@SERVICENAME
                         END,
       @Net_Start_Agent = CASE
                            WHEN @@SERVICENAME = 'MSSQLSERVER' THEN 'NET START SQLSERVERAGENT'
                            ELSE 'NET START SQLAgent$' + @@SERVICENAME
                          END;

EXEC msdb.dbo.Sp_set_sqlagent_properties @email_save_in_sent_folder=1;
EXEC master.dbo.Sp_mssetalertinfo @pagersendsubjectonly = 0;
EXEC master.dbo.Xp_instance_regread
  N'HKEY_LOCAL_MACHINE',
  N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
  N'DatabaseMailProfile';
EXEC master.dbo.Xp_instance_regwrite
  N'HKEY_LOCAL_MACHINE',
  N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
  N'UseDatabaseMail',
  N'REG_DWORD',
  1;
EXEC master.dbo.Xp_instance_regwrite
  N'HKEY_LOCAL_MACHINE',
  N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
  N'DatabaseMailProfile',
  N'REG_SZ',
  'BSERP_RDC_ETLErrorProfile';

EXEC master..sp_configure @Advanced_Options, 1  ;
RECONFIGURE  ;
EXEC master..sp_configure @XP_CMDShell, 1        ;
RECONFIGURE  ;
EXEC master..Xp_cmdshell @Net_Stop_Agent;

EXEC master..Xp_cmdshell @Net_Start_Agent;
IF EXISTS (SELECT name
           FROM   msdb.dbo.sysoperators
           WHERE  name = 'BSERPRDCOperate')
  BEGIN
      EXEC msdb..Sp_delete_operator @name = 'BSERPRDCOperate'
  END
EXEC msdb.dbo.Sp_add_operator
  @name = 'BSERPRDCOperate',
  @enabled = 1,
  @weekday_pager_start_time = 90000,
  @weekday_pager_end_time = 180000,
  @saturday_pager_start_time = 90000,
  @saturday_pager_end_time = 180000,
  @sunday_pager_start_time = 90000,
  @sunday_pager_end_time = 180000,
  @pager_days = 127,
  @email_address = 'liangyong1107@126.com',
  @pager_address = N'',
  @netsend_address = N'';
IF EXISTS (SELECT 1
           FROM   msdb.dbo.sysjobs
           WHERE  name = 'RdcSchedule')
  BEGIN
      EXEC msdb.dbo.Sp_update_job
        @job_name = 'RdcSchedule',
        @notify_level_email = 2,
        @notify_level_netsend = 2,
        @notify_level_page = 2,
        @notify_email_operator_name = 'BSERPRDCOperate' 
  END;

