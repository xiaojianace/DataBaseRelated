/*
	功能说明：  KILL SQL数据库死锁进程
	修改说明：	Create by LY on 2012-06-12
*/
IF Object_id('', 'P') IS NOT NULL
  DROP PROC Sp_KillAllProcessInDB

go

CREATE PROC Sp_KillAllProcessInDB @DbName VARCHAR(100)
AS
    IF Db_id(@DbName) = NULL
      BEGIN
          PRINT 'DataBase dose not Exist'
      END
    ELSE
      BEGIN
          DECLARE @spId VARCHAR(30)
          DECLARE TmpCursor CURSOR FOR
            SELECT 'Kill ' + CONVERT(VARCHAR, spid) AS spId
            FROM   master..SysProcesses
            WHERE  Db_name(dbID) = @DbName
                   AND spId <> @@SPID
                   AND dbID <> 0

          OPEN TmpCursor

          FETCH NEXT FROM TmpCursor INTO @spId

          WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC (@spId)

                FETCH NEXT FROM TmpCursor INTO @spId
            END

          CLOSE TmpCursor

          DEALLOCATE TmpCursor
      END

GO 
