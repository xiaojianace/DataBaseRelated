create function f_ch2py(@chn nchar(1))
returns char(1)
as
begin
declare @n int
declare @c char(1)
set @n = 63
select @n = @n +1,
       @c = case chn when @chn then char(@n) else @c end
from(
select top 27 * from (
     select chn =
'߹' union all select
'��' union all select
'��' union all select
'��' union all select
'��' union all select
'��' union all select
'�' union all select
'��' union all select
'آ' union all select  --because have no 'i'
'آ' union all select
'��' union all select
'��' union all select
'�`' union all select
'��' union all select
'��' union all select
'�r' union all select
'��' union all select
'��' union all select
'��' union all select
'��' union all select
'��' union all select  --no 'u'
'��' union all select  --no 'v'
'��' union all select
'Ϧ' union all select
'Ѿ' union all select
'��' union all select @chn) as a
order by chn COLLATE Chinese_PRC_CI_AS
) as b
return(@c)
end
go
 
--�÷���
select dbo.f_ch2py('�����й���')