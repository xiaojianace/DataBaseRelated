/*
	����˵����  �޸ĸñ�����Լ��Ϊ�ۼ�������Ǿۼ�����
	�޸�˵����	Create by LY on 2012-6-4
	            Modify by LY on 2012-6-9 �޸�����Ϊ���������ж�
*/
IF EXISTS (SELECT 1
           FROM   sysobjects
           WHERE  ID = Object_id(N'ModifyPrimaryKeyConstraintByTableName')
                  AND Objectproperty(ID, N'IsProcedure') = 1)
  BEGIN
      DROP PROCEDURE ModifyPrimaryKeyConstraintByTableName
  END

GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
--SET NOCOUNT ON
GO

CREATE PROCEDURE [dbo].[ModifyPrimaryKeyConstraintByTableName] 
(
      @TableName VARCHAR(500) = 'SHANGPIN',  ---��
      @ISFlag BIT = TRUE          ---�޸ĸñ�����Ϊ�ۼ���Ǿۼ�,True��ʾ�Ǿۼ�������false�Ǿۼ�����
)
AS
  SET NOCOUNT ON;  ----��Ӳ�����Ӱ�������
  BEGIN
   DECLARE @SQL VARCHAR(MAX),@TablePKName VARCHAR(100),
           @TableFieldName VARCHAR(100)='',@IndexTypeName VARCHAR(50); 
   IF(@ISFlag = 1)
     SET  @IndexTypeName ='CLUSTERED';
   ELSE
     SET  @IndexTypeName ='NONCLUSTERED';
    
	 DECLARE @PrimaryMessage TABLE (
	  TableQualifier VARCHAR(100),
	  TableOwner     VARCHAR(100),
	  TableName      VARCHAR(100),
	  ColumnName     VARCHAR(100),
	  KeySeq         VARCHAR(100),
	  Pk_Name        VARCHAR(100));

	INSERT INTO @PrimaryMessage
	EXEC('
	EXEC   SP_PKEYS   @table_name= '+@TableName+ ' 
	')

	SELECT @TablePKName = Pk_Name,@TableFieldName += ','+ColumnName
	FROM   @PrimaryMessage 
    SET @TableFieldName =STUFF(@TableFieldName,1,1,'')

   DECLARE @ForeignPrimaryMessage TABLE (
    ForeignName       VARCHAR(100),
    ForeignTable       VARCHAR(100),
    ForeignField  VARCHAR(100),
    PrimaryTable VARCHAR(100),
    PrimaryField VARCHAR(100)
  );

  
SET @SQL ='
 SELECT [�����],
       [�����],
       [�����],
       [������],
       [������]
FROM   (SELECT FK_Name             AS [�����],
               Parent_Tab_Name     AS [�����],
               [�����]=Stuff((SELECT '','' + [Parent_Col_Name]
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
                                                AND Parent_Tab.TYPE = ''U''
                                           INNER JOIN sys.columns Parent_Col
                                             ON Parent_Tab.Object_ID = Parent_Col.object_id
                                                AND Col.parent_column_id = Parent_Col.column_id
                                           INNER JOIN sys.objects Referenced_Tab
                                             ON Col.referenced_object_id = Referenced_Tab.Object_ID
                                                AND Referenced_Tab.TYPE = ''U''
                                           INNER JOIN sys.columns Referenced_Col
                                             ON Referenced_Tab.Object_ID = Referenced_Col.object_id
                                                AND Col.referenced_column_id = Referenced_Col.column_id)t
                            WHERE  FK_Name = tb.FK_Name
                                   AND Parent_Tab_Name = tb.Parent_Tab_Name
                                   AND Referenced_Tab_Name = tb.Referenced_Tab_Name
                            FOR xml path('''')), 1, 1, ''''),
               Referenced_Tab_Name AS [������],
               [������]=Stuff((SELECT '','' + [Referenced_Col_Name]
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
                                                AND Parent_Tab.TYPE = ''U''
                                           INNER JOIN sys.columns Parent_Col
                                             ON Parent_Tab.Object_ID = Parent_Col.object_id
                                                AND Col.parent_column_id = Parent_Col.column_id
                                           INNER JOIN sys.objects Referenced_Tab
                                             ON Col.referenced_object_id = Referenced_Tab.Object_ID
                                                AND Referenced_Tab.TYPE = ''U''
                                           INNER JOIN sys.columns Referenced_Col
                                             ON Referenced_Tab.Object_ID = Referenced_Col.object_id
                                                AND Col.referenced_column_id = Referenced_Col.column_id)t
                            WHERE  FK_Name = tb.FK_Name
                                   AND Parent_Tab_Name = tb.Parent_Tab_Name
                                   AND Referenced_Tab_Name = tb.Referenced_Tab_Name
                            FOR xml path('''')), 1, 1, '''')
        --as [�����]
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
                            AND Parent_Tab.TYPE = ''U''
                       INNER JOIN sys.columns Parent_Col
                         ON Parent_Tab.Object_ID = Parent_Col.object_id
                            AND Col.parent_column_id = Parent_Col.column_id
                       INNER JOIN sys.objects Referenced_Tab
                         ON Col.referenced_object_id = Referenced_Tab.Object_ID
                            AND Referenced_Tab.TYPE = ''U''
                       INNER JOIN sys.columns Referenced_Col
                         ON Referenced_Tab.Object_ID = Referenced_Col.object_id
                            AND Col.referenced_column_id = Referenced_Col.column_id)tb
        GROUP  BY FK_Name,
                  Parent_Tab_Name,
                  Referenced_Tab_Name)A
WHERE  ������ = '''+@TableName+''' 
     ';
  
INSERT INTO @ForeignPrimaryMessage
EXEC (@SQL)


  /*
  	����˵����  �α��ʹ�� (�������жϷ�ʽ)
  	�޸�˵����	Create by LY on 2012-6-4 
  */
  DECLARE @ForeignName      VARCHAR(100),
          @ForeignTable      VARCHAR(100),
          @ForeignField VARCHAR(100),
          @PrimaryTable VARCHAR(100), 
          @PrimaryField   VARCHAR(100);
        
  DECLARE cur CURSOR fast_forward FOR ----------�α������
    SELECT *
    FROM   @ForeignPrimaryMessage 
  
  OPEN cur; ---------���α�
  FETCH next FROM cur INTO @ForeignName, @ForeignTable, @ForeignField, @PrimaryTable, @PrimaryField; 
  
  WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT( 'ALTER TABLE ' + @ForeignTable + '
  				DROP CONSTRAINT ' + @ForeignName + '' )
  				
     --PRINT( 'ALTER TABLE ' + @ForeignTable + '
  			--	ADD CONSTRAINT ' + @ForeignName + ' FOREIGN KEY('+@ForeignField+') REFERENCES
  			--	 '+@PrimaryTable+'('+@PrimaryField+')' )
  
        FETCH next FROM cur INTO @ForeignName, @ForeignTable, @ForeignField, @PrimaryTable, @PrimaryField; 
    END
  
  CLOSE cur; ------�ر��α�
  DEALLOCATE cur; ------�ͷ��α�
  
  
  /*
    ����˵��:�����������Լ��
  */
  ------ɾ������
PRINT('ALTER TABLE '+@TableName+' DROP constraint '+@TablePKName+' ')

PRINT('
	ALTER TABLE '+@TableName+' ADD CONSTRAINT '+@TablePKName+' PRIMARY KEY '+@IndexTypeName+'  
	(  
	   '+@TableFieldName+'
	) ON [PRIMARY]  
	');
  
  
  DECLARE @ForeignName1      VARCHAR(100),
          @ForeignTable1      VARCHAR(100),
          @ForeignField1 VARCHAR(100),
          @PrimaryTable1 VARCHAR(100), 
          @PrimaryField1   VARCHAR(100);
        
  DECLARE cur1 CURSOR fast_forward FOR ----------�α������
    SELECT *
    FROM   @ForeignPrimaryMessage 
  
  OPEN cur1; ---------���α�
  FETCH next FROM cur1 INTO @ForeignName1, @ForeignTable1, @ForeignField1, @PrimaryTable1, @PrimaryField1; 
  
  WHILE @@FETCH_STATUS = 0
    BEGIN
    --    PRINT( 'ALTER TABLE ' + @ForeignTable1 + '
  		--		DROP CONSTRAINT ' + @ForeignName1 + '' )
  				
     PRINT( 'ALTER TABLE ' + @ForeignTable1 + '
  				ADD CONSTRAINT ' + @ForeignName1 + ' FOREIGN KEY('+@ForeignField1+') REFERENCES
  				 '+@PrimaryTable1+'('+@PrimaryField1+')' );
  
        FETCH next FROM cur1 INTO @ForeignName1, @ForeignTable1, @ForeignField1, @PrimaryTable1, @PrimaryField1; 
    END
  
  CLOSE cur1; ------�ر��α�
  DEALLOCATE cur1; ------�ͷ��α�
  
  
  --SELECT *
  --FROM   @IndexDetailMessage
  

  

  END


