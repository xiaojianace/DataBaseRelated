SELECT *
FROM   BBBB(nolock) ----就是执行没有锁定的信息。

DECLARE @Errs INT;

SET @Errs=0;

BEGIN TRANSACTION ----开始事务


UPDATE BBBB
SET    name='BBBBB'
WHERE  ID = 3

UPDATE BBBB
SET    id = 'ss'
WHERE  ID = 2





IF @Errs = 0
  BEGIN
      COMMIT TRAN

      SELECT 0
  END
ELSE
  BEGIN
      ROLLBACK TRAN

      SELECT -1
  END
--ROLLBACK TRANSACTION  ----回滚事务
--COMMIT TRANSACTION   ----提交事务
