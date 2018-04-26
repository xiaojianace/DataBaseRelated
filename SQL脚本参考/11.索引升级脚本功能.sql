IF EXISTS (SELECT 1
           FROM   dbo.sysindexes
           WHERE  name = N'IX_Name_BBBB'
                  AND id = Object_id(N'BBBB'))
  BEGIN
      DROP INDEX BBBB.IX_Name_BBBB
  END

CREATE CLUSTERED INDEX IX_Name_BBBB
  ON BBB(QTimes)
  ON [PRIMARY]

GO