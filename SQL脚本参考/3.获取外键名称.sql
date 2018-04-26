SELECT [外键名],
       [外键表],
       [外键列],
       [主键表],
       [主键列]
FROM   (SELECT FK_Name             AS [外键名],
               Parent_Tab_Name     AS [外键表],
               [外键列]=Stuff((SELECT '，' + [Parent_Col_Name]
                            FROM   (SELECT FK.name             AS FK_Name,
                                           Parent_Tab.Name     AS Parent_Tab_Name,
                                           Parent_Col.Name     AS Parent_Col_Name,
                                           Referenced_Tab.Name AS Referenced_Tab_Name,
                                           Referenced_Col.Name AS Referenced_Col_Name
                                    FROM   sys.foreign_keys FK
                                           INNER JOIN sys.foreign_key_columns Col
                                             ON FK.Object_ID = Col.constraint_object_id
                                           INNER JOIN sys.objects Parent_Tab
                                             ON Col.parent_object_id = Parent_Tab.Object_ID
                                                AND Parent_Tab.TYPE = 'U'
                                           INNER JOIN sys.columns Parent_Col
                                             ON Parent_Tab.Object_ID = Parent_Col.object_id
                                                AND Col.parent_column_id = Parent_Col.column_id
                                           INNER JOIN sys.objects Referenced_Tab
                                             ON Col.referenced_object_id = Referenced_Tab.Object_ID
                                                AND Referenced_Tab.TYPE = 'U'
                                           INNER JOIN sys.columns Referenced_Col
                                             ON Referenced_Tab.Object_ID = Referenced_Col.object_id
                                                AND Col.referenced_column_id = Referenced_Col.column_id)t
                            WHERE  FK_Name = tb.FK_Name
                                   AND Parent_Tab_Name = tb.Parent_Tab_Name
                                   AND Referenced_Tab_Name = tb.Referenced_Tab_Name
                            FOR xml path('')), 1, 1, ''),
               Referenced_Tab_Name AS [主键表],
               [主键列]=Stuff((SELECT '，' + [Referenced_Col_Name]
                            FROM   (SELECT FK.name             AS FK_Name,
                                           Parent_Tab.Name     AS Parent_Tab_Name,
                                           Parent_Col.Name     AS Parent_Col_Name,
                                           Referenced_Tab.Name AS Referenced_Tab_Name,
                                           Referenced_Col.Name AS Referenced_Col_Name
                                    FROM   sys.foreign_keys FK
                                           INNER JOIN sys.foreign_key_columns Col
                                             ON FK.Object_ID = Col.constraint_object_id
                                           INNER JOIN sys.objects Parent_Tab
                                             ON Col.parent_object_id = Parent_Tab.Object_ID
                                                AND Parent_Tab.TYPE = 'U'
                                           INNER JOIN sys.columns Parent_Col
                                             ON Parent_Tab.Object_ID = Parent_Col.object_id
                                                AND Col.parent_column_id = Parent_Col.column_id
                                           INNER JOIN sys.objects Referenced_Tab
                                             ON Col.referenced_object_id = Referenced_Tab.Object_ID
                                                AND Referenced_Tab.TYPE = 'U'
                                           INNER JOIN sys.columns Referenced_Col
                                             ON Referenced_Tab.Object_ID = Referenced_Col.object_id
                                                AND Col.referenced_column_id = Referenced_Col.column_id)t
                            WHERE  FK_Name = tb.FK_Name
                                   AND Parent_Tab_Name = tb.Parent_Tab_Name
                                   AND Referenced_Tab_Name = tb.Referenced_Tab_Name
                            FOR xml path('')), 1, 1, '')
        --as [外键列]
        FROM   (SELECT FK.name             AS FK_Name,
                       Parent_Tab.Name     AS Parent_Tab_Name,
                       Parent_Col.Name     AS Parent_Col_Name,
                       Referenced_Tab.Name AS Referenced_Tab_Name,
                       Referenced_Col.Name AS Referenced_Col_Name
                FROM   sys.foreign_keys FK
                       INNER JOIN sys.foreign_key_columns Col
                         ON FK.Object_ID = Col.constraint_object_id
                       INNER JOIN sys.objects Parent_Tab
                         ON Col.parent_object_id = Parent_Tab.Object_ID
                            AND Parent_Tab.TYPE = 'U'
                       INNER JOIN sys.columns Parent_Col
                         ON Parent_Tab.Object_ID = Parent_Col.object_id
                            AND Col.parent_column_id = Parent_Col.column_id
                       INNER JOIN sys.objects Referenced_Tab
                         ON Col.referenced_object_id = Referenced_Tab.Object_ID
                            AND Referenced_Tab.TYPE = 'U'
                       INNER JOIN sys.columns Referenced_Col
                         ON Referenced_Tab.Object_ID = Referenced_Col.object_id
                            AND Col.referenced_column_id = Referenced_Col.column_id)tb
        GROUP  BY FK_Name,
                  Parent_Tab_Name,
                  Referenced_Tab_Name)A
WHERE  主键表 = 'SHANGPIN' 

--SP_HELP SHANGPIN