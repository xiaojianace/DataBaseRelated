/*
  功能说明:数据库邮件信息配置
  修改说明:Created BY LY 2012-7-6
*/
DECLARE @Advanced_Options VARCHAR(35) = 'SHOW ADVANCED OPTIONS',
        @Database_Mail    VARCHAR(35) = 'DATABASE MAIL XPS';

EXEC master..sp_configure @Advanced_Options,1
RECONFIGURE
EXEC master..sp_configure @Database_Mail,1
RECONFIGURE

IF EXISTS (SELECT name 
           FROM [msdb].[dbo].[sysmail_account] 
           WHERE name = 'BSERP_RDC_ETLErrorMail')
BEGIN
EXEC msdb..sysmail_delete_account_sp @ACCOUNT_NAME = 'BSERP_RDC_ETLErrorMail'  
END
EXEC msdb..sysmail_add_account_sp       
	@ACCOUNT_NAME = 'BSERP_RDC_ETLErrorMail',                 
	@EMAIL_ADDRESS = 'bserp_rdc_mail@126.com',       
	@DISPLAY_NAME = '系统管理员',                   
	@REPLYTO_ADDRESS = NULL,    
	@DESCRIPTION = NULL,       
	@MAILSERVER_NAME = 'SMTP.126.COM',            
	@MAILSERVER_TYPE = 'SMTP',                    
	@PORT = 25,                                        
	@USERNAME = 'bserp_rdc_mail@126.com',          
	@PASSWORD = 'rdcmail',                        
	@USE_DEFAULT_CREDENTIALS = 0,       
	@ENABLE_SSL = 0,       
	@ACCOUNT_ID = NULL
	
IF EXISTS (SELECT name 
           FROM [msdb].[dbo].sysmail_profile 
           WHERE name = 'BSERP_RDC_ETLErrorProfile')
BEGIN
EXEC msdb..sysmail_delete_profile_sp @profile_name = 'BSERP_RDC_ETLErrorProfile' 
END
EXEC msdb..sysmail_add_profile_sp 
	@profile_name = 'BSERP_RDC_ETLErrorProfile',                                             
	@description = 'BSERPRDC产品数据库邮件配置文件',                                       
	@profile_id = null
	
EXEC msdb..sysmail_add_profileaccount_sp  
	@profile_name = 'BSERP_RDC_ETLErrorProfile',                                            
	@account_name = 'BSERP_RDC_ETLErrorMail',                                         
	@sequence_number = 1             