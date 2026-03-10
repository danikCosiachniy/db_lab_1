--Добавить партию в Stock (INSERT)
CREATE OR ALTER PROCEDURE dbo.sp_add_stock_batch
    @pharmacy_id INT,
    @variant_id  INT,
    @quantity    INT,
    @price       DECIMAL(12,2),
    @lot_date    DATE,
    @exp_date    DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @medicine_id INT;

    SELECT @medicine_id = mv.medicine_id
    FROM dbo.MedicineVariant mv
    WHERE mv.variant_id = @variant_id;

    IF @medicine_id IS NULL
    BEGIN
        RAISERROR(N'variant_id не найден в MedicineVariant.', 16, 1);
        RETURN;
    END

    INSERT INTO dbo.Stock (variant_id, quantity, price, exp_date, lot_date, medicine_id, pharmacy_id)
    VALUES (@variant_id, @quantity, @price, @exp_date, @lot_date, @medicine_id, @pharmacy_id);
END;
GO