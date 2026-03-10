CREATE UNIQUE NONCLUSTERED INDEX UX_Pharmacy_Phone_NotNull
ON dbo.Pharmacy (phone)
WHERE phone IS NOT NULL;
GO