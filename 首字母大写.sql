--Ê××ÖÄ¸´óÐ´
create   function   f_Trans(@col   varchar(2000))   
 returns   varchar(2000)   
 as   
 begin
    set @col=replace(@col,'  ',' ')
     set @col=replace(@col,',','**,')
     set @col=replace(@col,' ',',')
     
    declare @sql varchar(2000)   
    set   @sql=''
    while charindex(',',@col)>0
        select @sql=@sql+upper(left(@col,1))+LOWER(replace(substring(@col,2,charindex(',',@col)-1),',',' ')),
        @col=substring(@col,charindex(',',@col)+1,len(@col)-charindex(',',@col))    
    set   @sql=@sql+upper(left(@col,1)) + replace(LOWER(right(@col,len(@col)-1)),',',' ')
    set @sql=replace(@sql,'** ',',')
    set @sql=replace(@sql,',,',', ')
    return(@sql)
end

go