--Партии с истекающим сроком годности в ближайшие 30 дней
CREATE OR ALTER PROCEDURE dbo.sp_expiring_30d
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        s.stock_id,
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
    WHERE s.exp_date IS NOT NULL
      AND s.exp_date >= CAST(GETDATE() AS date)
      AND s.exp_date <  DATEADD(DAY, 30, CAST(GETDATE() AS date))
    ORDER BY s.exp_date;
END;
GO