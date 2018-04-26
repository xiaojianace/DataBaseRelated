
/*
 功能说明：有引用关系的修改主键方式
*/
------删除外键约束
ALTER TABLE Fact_SaleCar1 DROP constraint FK_Fact_SaleCar1_AAAA


------删除主键
ALTER TABLE AAAA DROP constraint PK_AAAA 

---修改主键为聚集索引
ALTER TABLE AAAA ADD CONSTRAINT PK_AAAA PRIMARY KEY CLUSTERED  
(  
   ID
) ON [PRIMARY]  
GO

-----添加外键约束
ALTER TABLE Fact_SaleCar1 ADD CONSTRAINT FK_Fact_SaleCar1_AAAA
 FOREIGN KEY(aaaID) REFERENCES AAAA(ID)