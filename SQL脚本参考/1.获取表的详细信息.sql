/*
	����˵����  ��ȡ�����ϸ��Ϣ
	�޸�˵����	Create by LY on 2012-5-30
*/
SELECT [����]=CASE
              WHEN a.colorder = 1 THEN d.name
              ELSE ''
            END,
       [��˵��]=CASE
               WHEN a.colorder = 1 THEN Isnull(f.value, '')
               ELSE ''
             END,
       [�ֶ����]=a.colorder,
       [�ֶ���]=a.name,
       [��ʶ]=CASE
              WHEN Columnproperty(a.id, a.name, 'IsIdentity') = 1 THEN '��'
              ELSE ''
            END,
       [����]=CASE
              WHEN EXISTS(SELECT 1
                          FROM   sysobjects
                          WHERE  xtype = 'PK'
                                 AND name IN (SELECT name
                                              FROM   sysindexes
                                              WHERE  indid IN(SELECT indid
                                                              FROM   sysindexkeys
                                                              WHERE  id = a.id
                                                                     AND colid = a.colid))) THEN '��'
              ELSE ''
            END,
       [����]=b.name,
       [ռ���ֽ���]=a.length,
       [����]=Columnproperty(a.id, a.name, 'PRECISION'),
       [С��λ��]=Isnull(Columnproperty(a.id, a.name, 'Scale'), 0),
       [�����]=CASE
               WHEN a.isnullable = 1 THEN '��'
               ELSE ''
             END,
       [Ĭ��ֵ]=Isnull(e.text, ''),
       [�ֶ�˵��]=Isnull(g.[value], ''),
       a.id,a.colid
FROM   syscolumns a
       LEFT JOIN systypes b
         ON a.xusertype = b.xusertype
       INNER JOIN sysobjects d
         ON a.id = d.id
            AND d.xtype = 'U'
            AND d.name <> 'dtproperties'
       LEFT JOIN syscomments e
         ON a.cdefault = e.id
       LEFT JOIN sys.extended_properties g
         ON a.id = g.major_id
            AND a.colid = g.minor_id
       LEFT JOIN sys.extended_properties f
         ON d.id = f.major_id
            AND f.minor_id = 0
WHERE  d.name = 'LSXHDZP' --���ֻ��ѯָ����,���ϴ�����
ORDER  BY a.id,
          a.colorder

