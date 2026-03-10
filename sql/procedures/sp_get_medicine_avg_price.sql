-- Получить среднюю цену препарата (обычная и взвешенная) + вывести в OUT
CREATE OR ALTER PROCEDURE dbo.sp_get_medicine_avg_price
    @medicine_id INT,
    @avg_price DECIMAL(18,2) OUTPUT,
    @avg_price_weighted DECIMAL(18,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        @avg_price = CAST(AVG(CAST(s.price AS decimal(18,4))) AS decimal(18,2)),
        @avg_price_weighted = CAST(
            SUM(s.price * s.quantity) / NULLIF(SUM(s.quantity), 0)
            AS decimal(18,2)
        )
    FROM dbo.Stock s
    WHERE s.medicine_id = @medicine_id;
END;
GO