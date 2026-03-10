--Поиск лекарства по названию (LIKE) + вывод где есть в наличии
CREATE OR ALTER PROCEDURE dbo.sp_find_medicine_in_stock
    @medicine_name NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.name_pharmacy,
        m.name_medicine,
        mv.dosage,
        s.quantity,
        s.price,
        s.exp_date
    FROM dbo.Stock s
    JOIN dbo.Pharmacy p         ON p.pharmacy_id = s.pharmacy_id
    JOIN dbo.MedicineVariant mv ON mv.variant_id = s.variant_id
    JOIN dbo.Medicine m         ON m.medicine_id = mv.medicine_id
    WHERE m.name_medicine LIKE N'%' + @medicine_name + N'%'
    ORDER BY m.name_medicine, mv.dosage, p.name_pharmacy;
END;
GO