USE PharmacyDB;
GO

/* 0) Удаляем FK Stock -> MedicineVariant (если он есть) */
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Stock_Variant')
BEGIN
    ALTER TABLE dbo.Stock DROP CONSTRAINT FK_Stock_Variant;
END
GO

/* 1) Если раньше создавался уникальный индекс на (medicine_id, dosage) — удалим */
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_MedicineVariant_MedicineId_Dosage' AND object_id = OBJECT_ID('dbo.MedicineVariant'))
BEGIN
    DROP INDEX UX_MedicineVariant_MedicineId_Dosage ON dbo.MedicineVariant;
END
GO

/* 2) Удаляем PK (кластерный) на variant_id */
IF EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'PK_MedicineVariant' AND parent_object_id = OBJECT_ID('dbo.MedicineVariant'))
BEGIN
    ALTER TABLE dbo.MedicineVariant DROP CONSTRAINT PK_MedicineVariant;
END
GO

/* 3) Возвращаем PK на variant_id как UNIQUE NONCLUSTERED (чтобы FK мог ссылаться) */
ALTER TABLE dbo.MedicineVariant
ADD CONSTRAINT PK_MedicineVariant PRIMARY KEY NONCLUSTERED (variant_id);
GO

/* 4) Создаём 1 УНИКАЛЬНЫЙ КЛАСТЕРНЫЙ индекс */
CREATE UNIQUE CLUSTERED INDEX UXC_MedicineVariant_MedicineId_Dosage
ON dbo.MedicineVariant (medicine_id, dosage);
GO

/* 5) Возвращаем FK Stock -> MedicineVariant */
ALTER TABLE dbo.Stock
ADD CONSTRAINT FK_Stock_Variant
FOREIGN KEY (variant_id) REFERENCES dbo.MedicineVariant(variant_id);
GO