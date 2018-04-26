--结合sys.indexes和sys.index_columns,sys.objects,sys.columns查询索引所属的表或视图的信息
select
  o.name as 表名,
  i.name as 索引名,
  c.name as 列名,
  i.type_desc as 类型描述,
  is_primary_key as 主键约束,
  is_unique_constraint as 唯一约束,
  is_disabled as 禁用
from
  sys.objects o 
inner join
  sys.indexes i
on
  i.object_id=o.object_id
inner join 
  sys.index_columns ic
on
  ic.index_id=i.index_id and ic.object_id=i.object_id
inner join
  sys.columns c
on
  ic.column_id=c.column_id and ic.object_id=c.object_id
go



--查询索引的键和列信息
select 
  o.name as 表名,
  i.name as 索引名,
  c.name as 字段编号,
from
  sysindexes i inner join sysobjects o 
on
  i.id=o.id
inner join
  sysindexkeys k 
on
  o.id=k.id and i.indid=k.indid
inner join
  syscolumns c 
on
  c.id=i.id and k.colid=c.colid
where
  o.name='表名'




--查询数据库db中表tb的所有索引的碎片情况
use db
go
select 
  a.index_id,---索引编号
  b.name,---索引名称
  avg_fragmentation_in_percent---索引的逻辑碎片
from
  sys.dm_db_index_physical_stats(db_id(),object_id(N'create.consume'),null,null,null) as a
join
  sys.indexes as b
on
  a.object_id=b.object_id 
and
  a.index_id=b.index_id
go

---解释下sys.dm_db_indx_physical_stats的参数
datebase_id: 数据库编号，可以使用db_id()函数获取指定数据库名对应的编号。
object_id: 该索引所属表或试图的编号
index_id: 该索引的编号
partition_number:对象中分区的编号
mode:模式名称,用于指定获取统计信息的扫描级别。


有关sys.dm_db_indx_physical_stats的结果集中的字段名去查下联机丛书。