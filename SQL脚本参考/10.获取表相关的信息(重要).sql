exec   sp_help @TableName  --得到表信息。字段，索引。constraint. 
exec   sp_pkeys @TableName  --得到主键。 
exec   sp_fkeys @TableName  --得到表的外键 
exec   sp_primarykeys @table_server  --得到远程表主键。


exec sp_helpindex 'SHANGPIN'   ---查看索引名称
EXEC sp_helpconstraint 'SHANGPIN';


