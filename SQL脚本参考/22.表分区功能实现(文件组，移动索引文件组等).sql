/*
  ����˵��:	���������ʵ��
  �޸�˵��:Created BY LY 2012-6-15
  ��ע˵��:   �������оۼ��������򽫴˾ۼ������ƶ������ļ����ͬʱҲ�Ὣ���ƶ������ļ��顣
				 ALTER TABLE SG_GATHERING DROP CONSTRAINT PK_SG_GATHERING
				  WITH (MOVE TO 'FG_PMCXD') 
*/
/*
  ����˵��:�����ļ���
  �޸�˵��:Created BY LY 2012-6-15
*/
ALTER DATABASE grnpa ADD FILEGROUP FG_PMCXD
ALTER DATABASE grnpa ADD FILE ( NAME = 'F_PMCXD',                                     FILENAME = 'D:\DB\DBTest\F_PMCXD.MDF', SIZE =5120KB ,                                           FILEGROWTH = 10% )  TO FILEGROUP FG_PMCXD ;
/*
  ����˵��:���е����������ļ��ƶ���ͬ���ļ���
  �޸�˵��:Created BY LY 2012-6-15
*/
ALTER TABLE MAKE
  				DROP CONSTRAINT PK_MAKE
ALTER TABLE MAKE WITH NOCHECK ADD CONSTRAINT 
  					   PK_MAKE PRIMARY KEY NONCLUSTERED (SPMK) 
  					   ON FG_PMCXD 
ALTER TABLE PMCXD
  				DROP CONSTRAINT PK_PMCXD
ALTER TABLE PMCXD WITH NOCHECK ADD CONSTRAINT 
  					   PK_PMCXD PRIMARY KEY NONCLUSTERED (DJBH) 
  					   ON FG_PMCXD 
DROP INDEX PMCXD.RQI
CREATE NONCLUSTERED INDEX
				RQI ON PMCXD(RQ,DJBH) 
				ON FG_PMCXD 
