/*
  ����˵��:��ȡ���������������ۼ����������Ϣ
  �޸�˵��:Created BY LY 2012-6-15
*/
SELECT *
FROM   (SELECT indexs.Tab_Name              AS [����],
               indexs.Index_Name            AS [������],
               indexs.[Co_Names]            AS [������],
               Ind_Attribute.is_primary_key AS [�Ƿ�����],
               Ind_Attribute.is_unique      AS [�Ƿ�Ψһ��],
               Ind_Attribute.is_disabled    AS [�Ƿ����],
               Ind_Attribute.type           AS [�Ƿ�ۼ�����]
        FROM   (SELECT Tab_Name,
                       Index_Name,
                       [Co_Names]=Stuff((SELECT ',' + [Co_Name]
                                         FROM   (SELECT tab.Name AS Tab_Name,
                                                        ind.Name AS Index_Name,
                                                        Col.Name AS Co_Name
                                                 FROM   sys.indexes ind
                                                        INNER JOIN sys.tables tab
                                                          ON ind.Object_id = tab.object_id
                                                             AND ind.type IN ( 1, 2 )
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
                                    AND ind.type IN ( 1, 2 )
                               INNER JOIN sys.index_columns index_columns
                                 ON tab.object_id = index_columns.object_id
                                    AND ind.index_id = index_columns.index_id
                               INNER JOIN sys.columns Col
                                 ON tab.object_id = Col.object_id
                                    AND index_columns.column_id = Col.column_id)tb
                WHERE  Tab_Name IN ( 'PMCXD', 'MAKE' )
                GROUP  BY Tab_Name,
                          Index_Name) indexs
               INNER JOIN sys.indexes Ind_Attribute
                 ON indexs.Index_Name = Ind_Attribute.name)A
GROUP  BY [����],
          [������],
          [������],
          [�Ƿ�����],
          [�Ƿ�Ψһ��],
          [�Ƿ����],
          [�Ƿ�ۼ�����] 
