--Возвращает партии, срок годности которых истекает в ближайшие N дней.
CREATE OR ALTER FUNCTION dbo.fn_expiring_batches
(
    @days INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        s.stock_id,
        s.pharmacy_id,
        p.name_pharmacy,
        s.medicine_id,
        m.name_medicine,
        s.variant_id,
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
      AND s.exp_date <  DATEADD(DAY, @days, CAST(GETDATE() AS date))
);
GO

SELECT * FROM dbo.fn_expiring_batches(30) ORDER BY exp_date;
GO