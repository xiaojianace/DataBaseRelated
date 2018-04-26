/*
 功能说明：根据表名，字段名获取该字段类型及长度
 修改说明: Created BY LY 2012-6-19
*/
SELECT t.name,
       c.length
FROM   sysobjects o,
       syscolumns c,
       systypes t
WHERE  o.id = c.id
       AND c.usertype = t.usertype
       AND o.name = 'SG_Gathering'
       AND c.name = 'Vshop' 
