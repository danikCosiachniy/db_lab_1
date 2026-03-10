--Возвращает общую стоимость партии: quantity * price.
CREATE OR ALTER FUNCTION dbo.fn_stock_line_total
(
    @quantity INT,
    @price DECIMAL(12,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    RETURN CAST(@quantity * @price AS DECIMAL(18,2));
END;
GO


SELECT dbo.fn_stock_line_total(10, 4.25) AS line_total;
GO