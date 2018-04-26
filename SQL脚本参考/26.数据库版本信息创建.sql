/*
	����˵����  ���ݿ�汾��Ϣ
	����˵��:   �����ű�
	�޸�˵����	Modify by LY on 2012-7-3 �ж��Ƿ���ڸð汾��Ϣ
*/
IF NOT EXISTS (SELECT 1
               FROM   dbo.sysobjects
               WHERE  id = Object_id(N'[dbo].[Databaseinfo]')
                      AND Objectproperty(id, N'IsUserTable') = 1)
  BEGIN
      CREATE TABLE [dbo].[Databaseinfo]
        (
           [Ver_No]      [VARCHAR] (50) NOT NULL,
           [Project_NO]  [VARCHAR] (50) NOT NULL,
           [BuildTime]   [VARCHAR] (50) NOT NULL,
           [Up_Kind]     [CHAR] (8) NOT NULL,
           [Update_Time] [DATETIME] NOT NULL,
           [DB_Kind]     [VARCHAR](20) NOT NULL
        )
      ON [PRIMARY]
  END
IF EXISTS (SELECT *
           FROM   DATABASEINFO
           WHERE  Ver_No = '2.0'
                  AND Project_no = 'DW_RDC'
                  AND BuildTime = '2.0.1'
                  AND Up_Kind = '�����汾')
  BEGIN
      SELECT 1
  END
ELSE
  BEGIN
      DELETE FROM DATABASEINFO
      WHERE  Ver_No = '2.0'
             AND BuildTime = '2.0.1'
             AND Project_no = 'DW_RDC'

      INSERT INTO DATABASEINFO
                  (Ver_No,
                   Project_no,
                   BuildTime,
                   Up_Kind,
                   DB_Kind,
                   Update_Time)
      VALUES      ('2.0',
                   'DW_RDC',
                   '2.0.1',
                   '�����汾 ',
                   '�ܲ����ݿ�',
                   Getdate())

      SELECT 0
  END 
