/*
	功能说明：  获取索引名称
	修改说明：	Create by LY on 2012-5-30
*/
SELECT indexs.Tab_Name              AS [表名],
       indexs.Index_Name            AS [索引名],
       indexs.[Co_Names]            AS [索引列],
       Ind_Attribute.is_primary_key AS [是否主键],
       Ind_Attribute.is_unique      AS [是否唯一键],
       Ind_Attribute.is_disabled    AS [是否禁用],
       Ind_Attribute.type           AS [索引类型]  ---1聚集索引，2非聚集索引
FROM   (SELECT Tab_Name,
               Index_Name,
               [Co_Names]=Stuff((SELECT '，' + [Co_Name]
                                 FROM   (SELECT tab.Name AS Tab_Name,
                                                ind.Name AS Index_Name,
                                                Col.Name AS Co_Name
                                         FROM   sys.indexes ind
                                                INNER JOIN sys.tables tab
                                                  ON ind.Object_id = tab.object_id
                                                     AND ind.type IN ( 1, 2 )/*索引的类型：=堆/1=聚集/2=非聚集/3=XML*/
                                                INNER JOIN sys.index_columns index_columns
                                                  ON tab.object_id = index_columns.object_id
                                                     AND ind.index_id = index_columns.index_id
                                                INNER JOIN sys.columns Col
                                                  ON tab.object_id = Col.object_id
                                                     AND index_columns.column_id = Col.column_id) t
                                 WHERE  Tab_Name = tb.Tab_Name
                                        AND Index_Name = tb.Index_Name
                                 FOR xml path('')), 1, 1, '')
        FROM   (SELECT tab.Name AS Tab_Name,
                       ind.Name AS Index_Name,
                       Col.Name AS Co_Name
                FROM   sys.indexes ind
                       INNER JOIN sys.tables tab
                         ON ind.Object_id = tab.object_id
                            AND ind.type IN ( 1, 2 )/*索引的类型：=堆/1=聚集/2=非聚集/3=XML*/
                       INNER JOIN sys.index_columns index_columns
                         ON tab.object_id = index_columns.object_id
                            AND ind.index_id = index_columns.index_id
                       INNER JOIN sys.columns Col
                         ON tab.object_id = Col.object_id
                            AND index_columns.column_id = Col.column_id)tb
        WHERE  Tab_Name NOT LIKE 'sys%'
        GROUP  BY Tab_Name,
                  Index_Name) indexs
       INNER JOIN sys.indexes Ind_Attribute
         ON indexs.Index_Name = Ind_Attribute.name
ORDER  BY indexs.Tab_Name 
