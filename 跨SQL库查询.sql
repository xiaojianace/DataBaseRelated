--����Ad Hoc Distributed Queries���
exec sp_configure 'show advanced options',1
reconfigure
exec sp_configure 'Ad Hoc Distributed Queries',1
RECONFIGURE

SELECT  *
FROM    OPENDATASOURCE('SQLOLEDB',
                       'Data Source=192.168.148.215\sql2008;User ID=SA;Password=erpcsb!@#123').[bserp2_zb_0803].[DBO].SHANGPIN
                       
                                       
--�ر�Ad Hoc Distributed Queries���
exec sp_configure 'Ad Hoc Distributed Queries',0
reconfigure
exec sp_configure 'show advanced options',0
RECONFIGURE

