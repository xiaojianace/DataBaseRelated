SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_Pagination]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_Pagination]
GO

Create    PROCEDURE SP_Pagination
/**//*
***************************************************************
** 千万数量级分页存储过程 **
***************************************************************
参数说明:
1.Tables :表名称,视图
2.PrimaryKey :主关键字
3.Sort :排序语句，不带Order By 比如：NewsID Desc,OrderRows Asc
4.CurrentPage :当前页码
5.PageSize :分页尺寸
6.Filter :过滤语句，不带Where 
7.Group :Group语句,不带Group By
效果演示：http://www.cn5135.com/_App/Enterprise/QueryResult.aspx
***************************************************************/
(
@Tables varchar(2000),
@PrimaryKey varchar(500),
@Sort varchar(500) = NULL,
@CurrentPage int = 1,
@PageSize int = 10,
@Fields varchar(2000) = '*',
@Filter varchar(1000) = NULL,
@Group varchar(1000) = NULL
)
AS
/**//*默认排序*/
IF @Sort IS NULL OR @Sort = ''
SET @Sort = @PrimaryKey
DECLARE @SortTable varchar(1000)
DECLARE @SortName varchar(1000)
DECLARE @strSortColumn varchar(1000)
DECLARE @operator char(2)
DECLARE @type varchar(1000)
DECLARE @prec int
/**//*设定排序语句.*/
IF CHARINDEX('DESC',@Sort)>0
BEGIN
SET @strSortColumn = REPLACE(@Sort, 'DESC', '')
SET @operator = '<='
END
ELSE
BEGIN
IF CHARINDEX('ASC', @Sort) = 0
SET @strSortColumn = REPLACE(@Sort, 'ASC', '')
SET @operator = '>='
END
IF CHARINDEX('.', @strSortColumn) > 0
BEGIN
SET @SortTable = SUBSTRING(@strSortColumn, 0, CHARINDEX('.',@strSortColumn))
SET @SortName = SUBSTRING(@strSortColumn, CHARINDEX('.',@strSortColumn) + 1, LEN(@strSortColumn))
END
ELSE
BEGIN
SET @SortTable = @Tables
SET @SortName = @strSortColumn
END
SELECT @type=t.name, @prec=c.prec
FROM sysobjects o 
JOIN syscolumns c on o.id=c.id
JOIN systypes t on c.xusertype=t.xusertype
WHERE o.name = @SortTable AND c.name = @SortName
IF CHARINDEX('char', @type) > 0
SET @type = @type + '(' + CAST(@prec AS varchar) + ')'
DECLARE @strPageSize varchar(500)
DECLARE @strStartRow varchar(500)
DECLARE @strFilter varchar(1000)
DECLARE @strSimpleFilter varchar(1000)
DECLARE @strGroup varchar(1000)
/**//*默认当前页*/
IF @CurrentPage < 1
SET @CurrentPage = 1
/**//*设置分页参数.*/
SET @strPageSize = CAST(@PageSize AS varchar(500))
SET @strStartRow = CAST(((@CurrentPage - 1)*@PageSize + 1) AS varchar(500))
/**//*筛选以及分组语句.*/
IF @Filter IS NOT NULL AND @Filter != ''
BEGIN
SET @strFilter = ' WHERE ' + @Filter + ' '
SET @strSimpleFilter = ' AND ' + @Filter + ' '
END
ELSE
BEGIN
SET @strSimpleFilter = ''
SET @strFilter = ''
END
IF @Group IS NOT NULL AND @Group != ''
SET @strGroup = ' GROUP BY ' + @Group + ' '
ELSE
SET @strGroup = ''
/**//*执行查询语句*/
EXEC(
'
DECLARE @SortColumn ' + @type + '
SET ROWCOUNT ' + @strStartRow + '
SELECT @SortColumn=' + @strSortColumn + ' FROM ' + @Tables + @strFilter + ' ' + @strGroup + ' ORDER BY ' + @Sort + '
SET ROWCOUNT ' + @strPageSize + '
SELECT ' + @Fields + ' FROM ' + @Tables + ' WHERE ' + @strSortColumn + @operator + ' @SortColumn ' + @strSimpleFilter + ' ' + @strGroup + ' ORDER BY ' + @Sort + '
'
)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


