--�������ӷ����� 
exec sp_addlinkedserver   'RemoteLink', ' ', 'SQLOLEDB ', '192.168.176.184' 
exec sp_addlinkedsrvlogin  'RemoteLink', 'false ',null, 'sa ', 'baisonrdc' 

--��ѯʾ�� 
select * from RemoteLink.[DW_RDC].dbo.Dim_VIP