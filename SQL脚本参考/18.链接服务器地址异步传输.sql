--创建链接服务器 
exec sp_addlinkedserver   'RemoteLink', ' ', 'SQLOLEDB ', '192.168.176.184' 
exec sp_addlinkedsrvlogin  'RemoteLink', 'false ',null, 'sa ', 'baisonrdc' 

--查询示例 
select * from RemoteLink.[DW_RDC].dbo.Dim_VIP