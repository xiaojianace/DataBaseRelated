--���sys.indexes��sys.index_columns,sys.objects,sys.columns��ѯ���������ı����ͼ����Ϣ
select
  o.name as ����,
  i.name as ������,
  c.name as ����,
  i.type_desc as ��������,
  is_primary_key as ����Լ��,
  is_unique_constraint as ΨһԼ��,
  is_disabled as ����
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



--��ѯ�����ļ�������Ϣ
select 
  o.name as ����,
  i.name as ������,
  c.name as �ֶα��,
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
  o.name='����'




--��ѯ���ݿ�db�б�tb��������������Ƭ���
use db
go
select 
  a.index_id,---�������
  b.name,---��������
  avg_fragmentation_in_percent---�������߼���Ƭ
from
  sys.dm_db_index_physical_stats(db_id(),object_id(N'create.consume'),null,null,null) as a
join
  sys.indexes as b
on
  a.object_id=b.object_id 
and
  a.index_id=b.index_id
go

---������sys.dm_db_indx_physical_stats�Ĳ���
datebase_id: ���ݿ��ţ�����ʹ��db_id()������ȡָ�����ݿ�����Ӧ�ı�š�
object_id: ���������������ͼ�ı��
index_id: �������ı��
partition_number:�����з����ı��
mode:ģʽ����,����ָ����ȡͳ����Ϣ��ɨ�輶��


�й�sys.dm_db_indx_physical_stats�Ľ�����е��ֶ���ȥ�����������顣