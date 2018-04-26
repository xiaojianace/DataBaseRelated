/*
  功能说明:分区函数分区功能实现
  修改说明:Created BY LY 2012-6-19
*/

/*
  功能说明:创建文件组
  修改说明:Created BY LY 2012-6-19
*/
ALTER DATABASE grnpa ADD FILEGROUP FG_SG_Gathering_021

ALTER DATABASE grnpa ADD FILE ( NAME = 'F_SG_Gathering_021', FILENAME = 'D:\DB\DBTest\F_SG_Gathering_021.MDF', SIZE =5120KB, FILEGROWTH = 10% ) TO FILEGROUP FG_SG_Gathering_021;

ALTER DATABASE grnpa ADD FILEGROUP FG_SG_Gathering_072

ALTER DATABASE grnpa ADD FILE ( NAME = 'F_SG_Gathering_072', FILENAME = 'D:\DB\DBTest\F_SG_Gathering_072.MDF', SIZE =5120KB, FILEGROWTH = 10% ) TO FILEGROUP FG_SG_Gathering_072;

ALTER DATABASE grnpa ADD FILEGROUP FG_SG_Gathering_S_0

ALTER DATABASE grnpa ADD FILE ( NAME = 'F_SG_Gathering_S_0', FILENAME = 'D:\DB\DBTest\F_SG_Gathering_S_0.MDF', SIZE =5120KB, FILEGROWTH = 10% ) TO FILEGROUP FG_SG_Gathering_S_0;


/*
  功能说明:创建分区函数
  修改说明:Created BY LY 2012-6-19
*/
IF EXISTS (SELECT *
           FROM   sys.partition_functions
           WHERE  name = N'PF_SG_Gathering_FirstLetter')
  DROP PARTITION FUNCTION PF_SG_Gathering_FirstLetter

CREATE PARTITION FUNCTION PF_SG_Gathering_FirstLetter(varchar(20)) AS RANGE RIGHT FOR VALUES ('021', '072', 'S_0')

/*
  功能说明:创建分区方案
  修改说明:Created BY LY 2012-6-19
*/
IF EXISTS (SELECT *
           FROM   sys.partition_schemes
           WHERE  name = N'PS_SG_Gathering_FirstLetter')
  DROP PARTITION SCHEME PS_SG_Gathering_FirstLetter

CREATE PARTITION SCHEME PS_SG_Gathering_FirstLetter AS PARTITION PF_SG_Gathering_FirstLetter TO (FG_SG_Gathering_021, FG_SG_Gathering_021, FG_SG_Gathering_072, FG_SG_Gathering_S_0)


/*
   功能说明:分区函数引用这个分区方案
  修改说明:Created BY LY 2012-6-19
*/
ALTER TABLE SG_Gathering
  DROP CONSTRAINT PK_SG_GATHERING

ALTER TABLE SG_Gathering
  WITH NOCHECK ADD CONSTRAINT PK_SG_GATHERING PRIMARY KEY CLUSTERED (vMBillID, vShop, vPFCode) ON PS_SG_Gathering_FirstLetter(Vshop) 
