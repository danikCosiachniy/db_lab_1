CREATE UNIQUE NONCLUSTERED INDEX UX_Medicine_Name_Manufacturer
ON dbo.Medicine (name_medicine, manufactured);
GO