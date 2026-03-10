--Сводка по аптеке: позиций, общий остаток, стоимость.
CREATE OR ALTER FUNCTION dbo.fn_pharmacy_summary
(
    @pharmacy_id INT
)
RETURNS @t TABLE
(
    pharmacy_id INT,
    name_pharmacy NVARCHAR(150),
    positions_count INT,
    total_units INT,
    total_value DECIMAL(18,2)
)
AS
BEGIN
    INSERT INTO @t (pharmacy_id, name_pharmacy, positions_count, total_units, total_value)
    SELECT
        p.pharmacy_id,
        p.name_pharmacy,
        COUNT(*) AS positions_count,
        SUM(s.quantity) AS total_units,
        CAST(SUM(s.quantity * s.price) AS DECIMAL(18,2)) AS total_value
    FROM dbo.Pharmacy p
    LEFT JOIN dbo.Stock s ON s.pharmacy_id = p.pharmacy_id
    WHERE p.pharmacy_id = @pharmacy_id
    GROUP BY p.pharmacy_id, p.name_pharmacy;

    RETURN;
END;
GO


SELECT * FROM dbo.fn_pharmacy_summary(1);
GO