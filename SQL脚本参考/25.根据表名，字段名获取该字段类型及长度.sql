/*
 ����˵�������ݱ������ֶ�����ȡ���ֶ����ͼ�����
 �޸�˵��: Created BY LY 2012-6-19
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
