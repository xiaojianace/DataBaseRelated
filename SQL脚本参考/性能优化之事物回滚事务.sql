SELECT *
FROM   BBBB(nolock) ----����ִ��û����������Ϣ��

DECLARE @Errs INT;

SET @Errs=0;

BEGIN TRANSACTION ----��ʼ����


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
--ROLLBACK TRANSACTION  ----�ع�����
--COMMIT TRANSACTION   ----�ύ����
