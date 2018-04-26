SELECT b.name,
       a.name
      
FROM   syscolumns a
       JOIN sysobjects b
         ON a.id = b.id
            AND b.xtype = 'U'
            AND b.name <> 'dtproperties'
WHERE  EXISTS (SELECT 1
               FROM   sysobjects
               WHERE  xtype = 'PK'
                      AND name IN (SELECT name
                                   FROM   sysindexes
                                   WHERE  indid IN (SELECT indid
                                                    FROM   sysindexkeys
                                                    WHERE  id = a.id
                                                           AND colid = a.colid)))
       AND b.name = 'shangpin' 

/*
功能说明:使用系统存储过程：exec   sp_pkeys   '表名 ' 

--SP_FKEYS等函数功能的使用学习运用等

*/
EXEC   SP_PKEYS   @table_name= 'shangpin ' 

