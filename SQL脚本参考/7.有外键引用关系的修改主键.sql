
/*
 ����˵���������ù�ϵ���޸�������ʽ
*/
------ɾ�����Լ��
ALTER TABLE Fact_SaleCar1 DROP constraint FK_Fact_SaleCar1_AAAA


------ɾ������
ALTER TABLE AAAA DROP constraint PK_AAAA 

---�޸�����Ϊ�ۼ�����
ALTER TABLE AAAA ADD CONSTRAINT PK_AAAA PRIMARY KEY CLUSTERED  
(  
   ID
) ON [PRIMARY]  
GO

-----������Լ��
ALTER TABLE Fact_SaleCar1 ADD CONSTRAINT FK_Fact_SaleCar1_AAAA
 FOREIGN KEY(aaaID) REFERENCES AAAA(ID)