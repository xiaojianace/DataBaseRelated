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
����˵��:ʹ��ϵͳ�洢���̣�exec   sp_pkeys   '���� ' 

--SP_FKEYS�Ⱥ������ܵ�ʹ��ѧϰ���õ�

*/
EXEC   SP_PKEYS   @table_name= 'shangpin ' 

