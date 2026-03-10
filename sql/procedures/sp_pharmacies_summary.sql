--Список всех аптек + сводка по запасам (позиции, штуки, стоимость)
CREATE OR ALTER PROCEDURE dbo.sp_pharmacies_summary
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.pharmacy_id,
        p.name_pharmacy,
        p.speciality,
        COUNT(s.stock_id) AS positions_count,
        COALESCE(SUM(s.quantity), 0) AS total_units,
        CAST(COALESCE(SUM(s.quantity * s.price), 0) AS decimal(18,2)) AS total_value
    FROM dbo.Pharmacy p
    LEFT JOIN dbo.Stock s ON s.pharmacy_id = p.pharmacy_id
    GROUP BY p.pharmacy_id, p.name_pharmacy, p.speciality
    ORDER BY total_value DESC, p.name_pharmacy;
END;
GO